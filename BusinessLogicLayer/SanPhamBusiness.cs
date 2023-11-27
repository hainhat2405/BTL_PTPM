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
        public List<HomeModel> GetAllMH()
        {
            return _res.GetAllMH();
        }
        public HomeModel GetMH_Ten(string name)
        {
            return _res.GetMH_Ten(name);
        }
        public List<HomeModel> GetMH_LH(string lh)
        {
            return _res.GetMH_LH(lh);
        }
        public List<HomeModel> GetMH_Top(int top)
        {
            return _res.GetMH_Top(top);
        }
        public List<HomeModel> GetMH_TopNew(int topnew)
        {
            return _res.GetMH_TopNew(topnew);
        }
        public List<HomeModel> GetMH_Gia(float gia)
        {
            return _res.GetMH_Gia(gia);
        }
        public List<HomeModel> GetMH_giaBanMinMax()
        {
            return _res.GetMH_giaBanMinMax();
        }
        public List<HomeModel> GetMH_giaBanMaxMin()
        {
            return _res.GetMH_giaBanMaxMin();
        }
        public List<HomeModel> GetMH_giaBan100k()
        {
            return _res.GetMH_giaBan100k();
        }
        public List<HomeModel> GetMH_giaBan100k_200k()
        {
            return _res.GetMH_giaBan100k_200k();
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
