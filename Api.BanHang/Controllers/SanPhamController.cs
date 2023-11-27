using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusiness _sanphamBusiness;
        public SanPhamController(ISanPhamBusiness mathangBusiness)
        {
            _sanphamBusiness = mathangBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetChiTietMatHang(string id)
        {
            return _sanphamBusiness.GetChiTietMatHang(id);
        }
        [Route("create-sanpham")]
        [HttpPost]
        public SanPhamModel CreateItem([FromBody] SanPhamModel model)
        {
            _sanphamBusiness.Create(model);
            return model;
        }
        [Route("update-sanpham")]
        [HttpPost]
        public SanPhamModel UpdateItem([FromBody] SanPhamModel model)
        {
            _sanphamBusiness.Update(model);
            return model;
        }
        [Route("delete-sanpham")]
        [HttpDelete]
        public IActionResult DeleteItem(string id)
        {
            _sanphamBusiness.Delete(id);
            return Ok(id);
        }
    }
}
