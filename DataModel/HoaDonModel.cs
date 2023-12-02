using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonModel
    {
        public int MaHoaDonBan { get; set; }
        public string KhachHangID { get; set; }
        public DateTime NgayBan { get; set; }

        public DateTime Ngaytao { get; set; }
        public float ThanhTien { get; set; }

        public int status { get; set; }
        public List<ChiTietHoaDonModel> list_json_chitietdonhangban { get; set; }
    }
    public class ChiTietHoaDonModel
    {
        public int MaChiTietHoaDon { get; set; }
        public int MaHoaDonBan { get; set; }
        public string MatHangID { get; set; }
        public int SoLuong { get; set; }
        public int GiaBan { get; set; }
        public int TongGia { get; set; }
    }
}