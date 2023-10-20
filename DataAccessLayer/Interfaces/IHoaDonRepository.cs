﻿using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer.Interfaces
{
    public partial interface IHoaDonRepository
    {
        HoaDonModel GetDatabyID(string id);
        bool Create(HoaDonModel model);
        bool Update(HoaDonModel model);

        bool Delete(string id);
        public List<ThongKeKhachModel> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}
