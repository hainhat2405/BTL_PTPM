using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interfaces
{
    public partial interface ISanPhamRepository
    {
        SanPhamModel GetChiTietMatHang(string id);
        List<HomeModel> GetAllMH();
        HomeModel GetMH_Ten(string name);
        HomeModel GetMH_LH(string lh);
        List<HomeModel> GetMH_Top(int top);
        List<HomeModel> GetMH_TopNew(int topnew);
        List<HomeModel> GetMH_Gia(int gia);
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);

        bool Delete(string id);
        //public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}
