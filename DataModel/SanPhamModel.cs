

namespace DataModel
{
    public class SanPhamModel
    {
        public string LoaiHangID { get; set; }
        public string MatHangId { get; set; }

        public string TenHang { get; set; }

        public string DVTinh { get; set; }
        public int SLTon { get; set; }
        //public List<MatHangModel> list_json_chitietmathang { get; set; }
    }

    public class ChiTietHoaDonBanModel
    {
        public int MaChiTietHoaDonBan { get; set; }
        public int MaHoaDonBan { get; set; }

        public int SoLuong { get; set; }

        public float GiaBan { get; set; }
    }
}
