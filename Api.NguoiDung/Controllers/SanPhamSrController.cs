using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.NguoiDung.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamSrController : ControllerBase
    {
        private ISanPhamBusiness _matHangBusiness;
        public SanPhamSrController(ISanPhamBusiness matHangBusiness)
        {
            _matHangBusiness = matHangBusiness;
        }
        [Route("getAllMatHang")]
        [HttpGet]   
        public List<SanPhamModel> GetAllMH()
        {
            return _matHangBusiness.GetAllMH();
        }
        [Route("getMH_Top")]
        [HttpGet]
        public List<SanPhamModel> GetMH_Top()
        {
            return _matHangBusiness.GetMH_Top();
        }
        [Route("get-by-name/{name}")]
        [HttpGet]
        public SanPhamModel GetMH_Ten(string name)
        {
            return _matHangBusiness.GetMH_Ten(name);
        }
        [Route("get-by-lh/{lh}")]
        [HttpGet]
        public SanPhamModel GetMH_LH(string lh)
        {
            return _matHangBusiness.GetMH_LH(lh);
        }
    }
}
