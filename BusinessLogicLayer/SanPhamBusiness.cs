﻿
using DataAccessLayer.Interfaces;
using BusinessLogicLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class SanPhamBusiness : ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }
        public SanPhamModel GetChiTietMatHang(string id)
        {
            return _res.GetChiTietMatHang(id);
        }
        public List<SanPhamModel> GetAllMH()
        {
            return _res.GetAllMH();
        }
        public List<SanPhamModel> GetMH_Top()
        {
            return _res.GetMH_Top();
        }
        public SanPhamModel GetMH_Ten(string name)
        {
            return _res.GetMH_Ten(name);
        }
        public SanPhamModel GetMH_LH(string lh)
        {
            return _res.GetMH_LH(lh);
        }
        public bool Create(SanPhamModel model)
        {
            return _res.Create(model);
        }
        public bool Update(SanPhamModel model)
        {
            return _res.Update(model);
        }
        public bool Delete(string id)
        {
            return _res.Delete(id);
        }

        //public List<KhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi)
        //{
        //    return _res.Search(pageIndex, pageSize, out total, ten_khach, dia_chi);
        //}
    }
}