using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MatHangController : ControllerBase
    {
        private IMatHangBusiness _mathangBusiness;
        public MatHangController(IMatHangBusiness mathangBusiness)
        {
            _mathangBusiness = mathangBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public MatHangModel GetChiTietMatHang(string id)
        {
            return _mathangBusiness.GetChiTietMatHang(id);
        }
        [Route("create-mathang")]
        [HttpPost]
        public MatHangModel CreateItem([FromBody] MatHangModel model)
        {
            _mathangBusiness.Create(model);
            return model;
        }
        [Route("update-mathang")]
        [HttpPost]
        public MatHangModel UpdateItem([FromBody] MatHangModel model)
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
