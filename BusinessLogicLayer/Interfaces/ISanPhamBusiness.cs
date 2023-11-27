using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer.Interfaces
{
    public partial interface ISanPhamBusiness
    {
        SanPhamModel GetChiTietMatHang(string id);
        List<HomeModel> GetAllMH();
        HomeModel GetMH_Ten(string name);
        List<HomeModel> GetMH_LH(string lh);
        List<HomeModel> GetMH_Top(int top);
        List<HomeModel> GetMH_TopNew(int topnew);
        List<HomeModel> GetMH_Gia(float gia);
        List<HomeModel> GetMH_giaBanMinMax();
        List<HomeModel> GetMH_giaBanMaxMin();
        List<HomeModel> GetMH_giaBan100k();
        List<HomeModel> GetMH_giaBan100k_200k();
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);
        bool Delete(string id);
    }
}
