﻿using BusinessLogicLayer.Interfaces;
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
    }
}
