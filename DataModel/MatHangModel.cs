

namespace DataModel
{
    public class MatHangModel
    {
        public string LoaiHangID { get; set; }
        public string MatHangId { get; set; }

        public string TenHang { get; set; }

        public string DVTinh { get; set; }
        public int SLTon { get; set; }
        public List<MatHangModel> list_json_chitietmathang { get; set; }
    }
}
