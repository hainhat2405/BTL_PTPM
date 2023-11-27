using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class NhanVienRepository : INhanVienRepository
    {
        private IDatabaseHelper _dbHelper;
        public NhanVienRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public NhanVienModel GetDatabyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "nhanvienID",
                     "@NhanVienID", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NhanVienModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(NhanVienModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "nhanvienCreate",
                "@NhanVienID", model.NhanVienID,
                "@HoTenNV", model.HoTenNV,
                "@GioiTinhNV", model.GioiTinhNV,
                "@NgaySinhNV", model.NgaySinhNV,
                "@DiaChiNV", model.DiaChiNV,
                 "@EmailNV", model.EmailNV,
                  "@SdtNV", model.SdtNV,
                   "@Matkhau", model.Matkhau);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Update(NhanVienModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "nhanvienUp",
               "@NhanVienID", model.NhanVienID,
                "@HoTenNV", model.HoTenNV,
                "@GioiTinhNV", model.GioiTinhNV,
                "@NgaySinhNV", model.NgaySinhNV,
                "@DiaChiNV", model.DiaChiNV,
                 "@EmailNV", model.EmailNV,
                  "@SdtNV", model.SdtNV,
                   "@Matkhau", model.Matkhau);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(string id)
        {
            string msgError = "";
            bool kq;
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "nhanvienDel",
                     "@NhanVienID", id);

                if (Convert.ToInt32(result) > 0)
                {
                    kq = true;
                }
                else
                {
                    kq = false;
                }
                return kq;
            }
            catch (Exception ex)



            {
                throw ex;
            }

        }
    }
}
