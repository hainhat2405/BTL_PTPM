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
        private ISanPhamBusiness _mathangBusiness;
        public SanPhamController(ISanPhamBusiness mathangBusiness)
        {
            _mathangBusiness = mathangBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetChiTietMatHang(string id)
        {
            return _mathangBusiness.GetChiTietMatHang(id);
        } 
        [Route("get-by-id/{id}")]
        [HttpGet]
        public SanPhamModel GetChiTietMatHang(string id)
        {
            return _mathangBusiness.GetChiTietMatHang(id);
        }
        [Route("create-mathang")]
        [HttpPost]
        public SanPhamModel CreateItem([FromBody] SanPhamModel model)
        {
            _mathangBusiness.Create(model);
            return model;
        }
        [Route("update-mathang")]
        [HttpPost]
        public SanPhamModel UpdateItem([FromBody] SanPhamModel model)
        {
            _mathangBusiness.Update(model);
            return model;
        }
        [Route("delete-mathang")]
        [HttpDelete]
        public IActionResult DeleteItem(string id)
        {
            _mathangBusiness.Delete(id);
            return Ok(id);
        }
    }
}
