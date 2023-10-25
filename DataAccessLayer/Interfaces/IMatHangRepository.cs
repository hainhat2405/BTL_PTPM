using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interfaces
{
    public partial interface IMatHangRepository
    {
        MatHangModel GetChiTietMatHang(string id);
        bool Create(MatHangModel model);
        bool Update(MatHangModel model);

        bool Delete(string id);
        //public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}
