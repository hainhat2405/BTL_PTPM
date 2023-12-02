
// var curDate = new Date();
//                      
// // Ngày hiện tại
// var curDay = curDate.getDate();

// // Tháng hiện tại
// var curMonth = curDate.getMonth() + 1;
//  
// // Năm hiện tại
// var curYear = curDate.getFullYear();

// // Gán vào thẻ HTML
// document.getElementById('current-time').innerHTML = curDay + "/" + curMonth + "/" + curYear;

// var danhmucsp = new Array();

// function themvaogiohang(x) {
//   var boxsp = x.parentElement.children;
//   var loaihangid = boxsp[0].children[0].children[1].value;
//   var mathang = boxsp[0].children[1].children[1].value;
//   var tenhang = boxsp[0].children[2].children[1].value;
//   var dvtinh = boxsp[0].children[3].children[1].value;
//   var soluong = boxsp[1].children[0].children[1].value;
//   var ngaytao = boxsp[1].children[1].children[1].value;
//   var anh = boxsp[1].children[2].children[1].value;

//   var sp = new Array(loaihangid, mathang, tenhang, dvtinh, soluong, ngaytao, anh);

//   danhmucsp.push(sp);

//   console.log(danhmucsp);
//   showcountsp();

//   // lưu giỏ hàng tren sessionStorage
//   sessionStorage.setItem("danhmucsp", JSON.stringify(danhmucsp));

// }

// function showsp(){
//     var sp = sessionStorage.getItem("danhmucsp");
//     var danhmucsp = JSON.parse(dmuc);
// }

// function showdmsp() {
//     var ttgh ="";
  
//     for(let i =0;i<giohang.length;i++){
//       var tt= parseInt(danhmucsp[i][1]) * parseInt(danhmucsp[i][2]*1000);
//       ttgh += '  <tr style="background: rgb(238, 238, 238);">'
//       '<td>91</td>'
//       '<td>'
//           '<input type="checkbox" name="" id="">'
//       '</td>'
//       '<td>3503</td>'
//       '<td>HDW_ADSNDF</td>'
//       '<td>Bánh đậu xanh Hoà An</td>'
//       '<td>Kẹo Hà Nội</td>'
//       '<td>09/03/2020</td>'
//       '<td><i class="fa-solid fa-magnifying-glass"></i></td>'
//       '<td><i class="fa fa-file"></i></td>'
//       '<td><i class="fa-solid fa-trash-can"></i></td>'
//   '</tr>'
//     }
//   }

//   function ThemSanPham() {
//     var loaihangid = document.getElementById("loaihangid").value;
//     var mathang = document.getElementById("mathang").value;
//     var tenhang = document.getElementById("tenhang").value;
//     var dvtinh = document.getElementById("dvtinh").value;
//     var sluong = document.getElementById("sluong").value;
//     var ngaytao = document.getElementById("ngaytao").value;
//     var anh = document.getElementById("anh").value;
//     var number = /^[0-9]+$/;

//     // if (masanpham == null || masanpham == "") {
//     //     var d = new Date();
//     //     masanpham = Number(d);
//     // }
//     // else if (!masanpham.match(number) || masanpham.length != 13) {
//     //     alert("Mã sản phẩm phải là kiểu số và có độ dài là 13 ký tự! Vui lòng nhập lại!");
//     //     return false;
//     // }

//     // if (loaisp == "choose") {
//     //     alert("Vui lòng chọn loại sản phẩm!");
//     //     return false;
//     // }
//     // else if (nhacungcap == "choose") {
//     //     alert("Vui lòng chọn nhà cung cấp!");
//     //     return false;
//     // }
//     // else if (tensanpham == null || tensanpham == "") {
//     //     alert("Tên sản phẩm không được để trống! Vui lòng nhập lại!");
//     //     return false;
//     // }
//     // else if (slsp == null || slsp == "") {
//     //     alert("Số lượng sản phẩm không được để trống! Vui lòng nhập lại!");
//     //     return false;
//     // } else if (slsp < 0) {
//     //     alert("Số lượng sản phẩm phải lớn hơn hoặc bằng 0! Vui lòng nhập lại!");
//     //     return false;
//     // }
//     // else if (giaban == null || giaban == "") {
//     //     alert("Giá bán sản phẩm không được để trống! Vui lòng nhập lại!");
//     //     return false;
//     // } else if (giaban <= 0) {
//     //     alert("Giá bán sản phẩm phải lớn hơn 0! Vui lòng nhập lại!");
//     //     return false;
//     // }
//     // else {
//     //     for (var x of list) {
//     //         if (x.masanpham == masanpham) {
//     //             alert("Mã sản phẩm đã tồn tại! Vui lòng nhập lại!")
//     //             return false;
//     //         }
//     //     }
//     // }

//     var list = JSON.parse(localStorage.getItem('Product')) || [];

//     console.log("AddProduct");
//     if (list == null) list = [];
//     var product = {
//         "loaihangid": loaihangid,
//         "mathang": mathang,
//         "tenhang": tenhang,
//         "dvtinh": dvtinh,
//         "sluong": sluong,
//         "ngaytao": ngaytao,
//         "anh": anh
//     };
//     list.push(product);
//     localStorage.setItem("Product", JSON.stringify(list));
//     alert("Đã thêm thành công!");
//     location.reload();
// }

// function LoadData() {
//   var str = "";
//   var sl = 0;
//   list.sort();
//   for (x of list) {
//       sl++;
//       str += `  <tr style="background: rgb(238, 238, 238);">
//       <td>`+x.loaihangid+`</td>
//       <td>
//       `+x.mathang+`
//       </td>
//       <td>`+x.tenhang+`</td>
//       <td>`+x.dvtinh+`</td>
//       <td>`+x.sluong+`</td>
//       <td>`+x.ngaytao+`i</td>
//       <td>`+x.anh+`</td>
//       <td><i class="fa-solid fa-magnifying-glass"></i></td>
//       <td><i class="fa fa-file"></i></td>
//       <td><i class="fa-solid fa-trash-can"></i></td>
//   </tr>`;
//   }
//   document.getElementById("infosp").innerHTML = str;
//   $('#soluong').html(sl);
// }
// LoadData();


















// function loadFile(event) {
//     var image = document.getElementById('viewimg');
//     image.src = URL.createObjectURL(event.target.files[0]);
// }
// function loadFile(event) {
//     var image = document.getElementById('viewimg');
//     image.src = URL.createObjectURL(event.target.files[0]);
    
//     // Hiển thị các nút button và di chuyển chúng xuống dưới ảnh
//     var buttons = document.querySelectorAll('.product_sp + button');
//     buttons.forEach(function(button) {
//         button.style.display = 'block';
//         button.style.
//         button.style.marginTop = '100px'; // Khoảng cách giữa các nút
//     });
// }

