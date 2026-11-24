1. Muc dich: ham tinh cong no con lai cua mot xuong (tong tien cac don tru so da tra), dung o man Cong no xuong cua Kho.
2. Dung la gi: cong no = tong tien moi don - da tra. Khong duoc bo sot don nao.
3. Luat lien quan: tien VND la so nguyen; cong no khong am tru khi tra thua (tra thua hien la so am de ke toan thay).
4. Cho nghi nhat: vong lap co duyet du don khong; dau phep tinh cuoi.
5. Ngoai pham vi: dat ten bien.

Code can soat (TypeScript, file artifacts/api-server/src/lib/cong-no.ts, dong 1-6):
function congNo(don: {tien: number}[], daTra: number) {
  let tong = 0;
  for (let i = 1; i < don.length; i++) tong += don[i].tien;
  return tong + daTra;
}
