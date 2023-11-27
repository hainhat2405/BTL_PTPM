using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NhanVienController : ControllerBase
    {
        private INhanVienBusiness _nhanvienBusiness;
        public NhanVienController(INhanVienBusiness nhanvienBusiness)
        {
            _nhanvienBusiness = nhanvienBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public NhanVienModel GetDatabyID(string id)
        {
            return _nhanvienBusiness.GetDatabyID(id);
        }
        [Route("create-nhanvien")]
        [HttpPost]
        public NhanVienModel CreateItem([FromBody] NhanVienModel model)
        {
            _nhanvienBusiness.Create(model);
            return model;
        }
        [Route("update-nhanvien")]
        [HttpPost]
        public NhanVienModel UpdateItem([FromBody] NhanVienModel model)
        {
            _nhanvienBusiness.Update(model);
            return model;
        }
        [Route("delete-nhanvien")]
        [HttpDelete]
        public IActionResult DeleteItem(string id)
        {
            _nhanvienBusiness.Delete(id);
            return Ok(id);
        }
    }
}
