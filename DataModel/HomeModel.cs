using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HomeModel
    {
        public string LoaiHangID { get; set; }
        public string MatHangID { get; set; }

        public string TenHang { get; set; }

        public string DVTinh { get; set; }
        public int SoLuong { get; set; }
        public DateTime NgayTao { get; set; }
        public int SoLuongDaBan { get; set; }
        public float GiaBan { get; set; }

    }
}
