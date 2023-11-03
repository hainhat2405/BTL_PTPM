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
        List<SanPhamModel> GetAllMH();
        List<SanPhamModel> GetMH_Top();
        SanPhamModel GetMH_Ten(string name);
        SanPhamModel GetMH_LH(string lh);
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);

        bool Delete(string id);
        //public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}
