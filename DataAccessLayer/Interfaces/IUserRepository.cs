﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer.Interfaces
{
    public partial interface IUserRepository
    {
        UserModel Login(string taikhoan, string matkhau);
    }
}
