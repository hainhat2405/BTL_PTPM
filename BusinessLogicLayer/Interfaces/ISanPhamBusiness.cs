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
        List<SanPhamModel> GetAllMH();
        List<SanPhamModel> GetMH_Top();
        SanPhamModel GetMH_Ten(string name);
        SanPhamModel GetMH_LH(string lh);
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);
        bool Delete(string id);
    }
}
