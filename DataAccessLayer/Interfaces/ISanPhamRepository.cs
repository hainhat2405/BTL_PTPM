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
        List<SanPhamUser> GetAllMH();
        SanPhamUser GetMH_Ten(string name);
        List<SanPhamUser> GetMH_LH(string lh);
        List<SanPhamUser> GetMH_Top(int top);
        List<SanPhamUser> GetMH_TopNew(int topnew);
        List<SanPhamUser> GetMH_Gia(float gia);
        List<SanPhamUser> GetMH_giaBanMinMax();
        List<SanPhamUser> GetMH_giaBanMaxMin();
        List<SanPhamUser> GetMH_giaBan100k();
        List<SanPhamUser> GetMH_giaBan100k_200k();

        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);

        bool Delete(string id);
        //public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}
