using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonModel
    {
        public string DonHangBanID { get; set; }
        public string NhanVienID { get; set; }
        public string KhachHangID { get; set; }
        public DateTime NgayBan { get; set; }
        public float TrietKhauBan { get; set; }

        public List<ChiTietHoaDonModel> list_json_chitietdonhangban { get; set; }

    }
    public class ChiTietHoaDonModel
    {
        public string DonHangBanID { get; set; }
        public string MatHangID { get; set; }
        public int SLBan { get; set; }
        public int DGBan { get; set; }
    }
}