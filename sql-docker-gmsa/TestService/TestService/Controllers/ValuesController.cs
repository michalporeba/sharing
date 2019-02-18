using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Runtime.InteropServices;
using Microsoft.AspNetCore.Mvc;

namespace TestService.Controllers
{
    [Route("api")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        // GET api/values
        [HttpGet("info")]
        public ActionResult<IEnumerable<string>> Info()
        {
            return new string[] { $"OS:  {RuntimeInformation.OSDescription}", $"Framework: {RuntimeInformation.FrameworkDescription}" };
        }

        [HttpGet("query/{server}/{db?}")]
        public ActionResult<string> Query(string server, string db = null)
        {
            var sql = @"
select 
	 @@version SqlServer
    ,db_name()  [Database]
	,current_user CurrentUser
	,original_login() OriginalLogin
for json path
";

            try
            {
                using (var conn =
                    new SqlConnection($"Server={server};Database={db ?? "master"};Trusted_Connection=true;"))
                using (var cmd = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    return cmd.ExecuteScalar().ToString();
                }
            }
            catch (Exception ex)
            {
                return $"Exception: {ex.Message}";
            }
        }
    }
}
