
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
    public class MatHangBusiness : IMatHangBusiness
    {
        private IMatHangRepository _res;
        public MatHangBusiness(IMatHangRepository res)
        {
            _res = res;
        }
        public MatHangModel GetChiTietMatHang(string id)
        {
            return _res.GetChiTietMatHang(id);
        }
        public bool Create(MatHangModel model)
        {
            return _res.Create(model);
        }
        public bool Update(MatHangModel model)
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
