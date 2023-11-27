using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class SanPhamRepository : ISanPhamRepository
    {
        private IDatabaseHelper _dbHelper;
        public SanPhamRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public SanPhamModel GetChiTietMatHang(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "mathangid",
                     "@MatHangID", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HomeModel> GetAllMH()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "mathang_getAll");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HomeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

      
        public HomeModel GetMH_Ten(string name)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "TimMatHangTheoTenHang",
                     "@TenHang", name);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HomeModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public HomeModel GetMH_LH(string lh)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "SearchMatHangByLoaiHang",
                     "@LoaiHangID", lh);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HomeModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HomeModel> GetMH_Top(int top)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "TopSellingProduct",
                     "@soluong", top);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HomeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HomeModel> GetMH_Gia(int gia)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "SearchMatHangByPrice",
                     "@GiaBan", gia);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HomeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HomeModel> GetMH_TopNew(int topnew)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "GetTopNNewestMatHangWithPrice",
                     "@New", topnew);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HomeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool Create(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "mathangCreate",
                "@LoaiHangID", model.LoaiHangID,
                "@MatHangID", model.MatHangID,
                "@TenHang", model.TenHang,
                "@DVTinh", model.DVTinh,
                "@SoLuong", model.SoLuong,
                "@NgayTao", model.NgayTao);
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
            public bool Update(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "mathangUpdate",
                "@MatHangID", model.MatHangID,
                "@LoaiHangID", model.LoaiHangID,
                "@TenHang", model.TenHang,
                "@DVTinh", model.DVTinh,
                "@SoLuong", model.SoLuong,
                "@NgayTao", model.NgayTao);
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
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "mathangDelete",
                     "@MatHangID", id);
              
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
