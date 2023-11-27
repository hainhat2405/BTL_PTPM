using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer.Interfaces
{
    public partial interface ITaiKhoanBusiness
    {
        TaiKhoanModel GetDatabyID(string id);
        bool Create(TaiKhoanModel model);
        bool Update(TaiKhoanModel model);
        bool Delete(string id);
    }
}
