using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TaiKhoanController : ControllerBase
    {
        private ITaiKhoanBusiness _tkBusiness;
        public TaiKhoanController(ITaiKhoanBusiness tkBusiness)
        {
            _tkBusiness = tkBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public UserModel GetDatabyID(string id)
        {
            return _tkBusiness.GetDatabyID(id);
        }
        [Route("create-taikhoan")]
        [HttpPost]
        public UserModel CreateItem([FromBody] UserModel model)
        {
            _tkBusiness.Create(model);
            return model;
        }
        [Route("update-taikhoan")]
        [HttpPost]
        public UserModel UpdateItem([FromBody] UserModel model)
        {
            _tkBusiness.Update(model);
            return model;
        }
        [Route("delete-taikhoan")]
        [HttpDelete]
        public IActionResult DeleteItem(string id)
        {
            _tkBusiness.Delete(id);
            return Ok(id);
        }
    }
}
