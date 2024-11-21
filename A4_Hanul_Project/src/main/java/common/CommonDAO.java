package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;

public class CommonDAO {
	private DBConnection pool;

	public CommonDAO() {
		try {
			pool = DBConnection.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 공통 ===============================================================================
	// 로그인
	public boolean Member_login(String usid, String uspw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select f01 from android where f01 = ? and f02 = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			pstmt.setString(2, uspw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 자료 1개 조회
	public Common1DTO Member_get(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Common1DTO bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from android where f01 = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Common1DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setF01(rs.getString("f01"));
				bean.setF02(rs.getString("f02"));
				bean.setF03(rs.getString("f03"));
				bean.setF04(rs.getString("f04"));
				bean.setF05(rs.getString("f05"));
				bean.setF06(rs.getString("f06"));
				bean.setF07(rs.getString("f07"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// Arduino 자료 저장을 위한 부분 ===============================================================================
	// 자료 추가
	public boolean Arduino_Insert(Common1DTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		Date nowTime = new Date();
		SimpleDateFormat nalja_f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		try {
			con = pool.getConnection();
			sql = "insert hanrasan01 (f01,f02,f03,f04,f05,f06,f07) values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF01());
			pstmt.setString(2, bean.getF02());
			pstmt.setString(3, bean.getF03());
			pstmt.setString(4, bean.getF04());
			pstmt.setString(5, bean.getF05());
			pstmt.setString(6, bean.getF06());
			pstmt.setString(7, nalja_f.format(nowTime));
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 자료 업데이트
	public boolean Arduino_Update(Common1DTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		// 현재 날짜 구하기
		Date nowTime = new Date();
		// 포맷 정의
	    SimpleDateFormat nalja_f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  // 데이터 포맷
		// 포맷 적용
	    //System.out.println(nalja_f.format(nowTime));

		try {
			con = pool.getConnection();
			// 온도 수정 bean.getF03()
			sql = "update Hanrasan02 set s02=?, s05=?, s06=? where s01 = ? and s03 = '00001' ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF02());
			pstmt.setString(2, bean.getF03());
			pstmt.setString(3, nalja_f.format(nowTime));
			pstmt.setString(4, bean.getF01());
			int count = pstmt.executeUpdate();
			
			// 습도 수정 bean.getF04()
			sql = "update Hanrasan02 set s02=?, s05=?, s06=? where s01 = ? and s03 = '00002' ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF02());
			pstmt.setString(2, bean.getF04());
			pstmt.setString(3, nalja_f.format(nowTime));
			pstmt.setString(4, bean.getF01());
			count = pstmt.executeUpdate();

			// 조도 수정 bean.getF05()
			sql = "update Hanrasan02 set s02=?, s05=?, s06=? where s01 = ? and s03 = '00003' ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF02());
			pstmt.setString(2, bean.getF05());
			pstmt.setString(3, nalja_f.format(nowTime));
			pstmt.setString(4, bean.getF01());
			count = pstmt.executeUpdate();

			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 자료 조회 (MAC address) 여러건 조회
	public Vector<Common2DTO> Arduino_Get1(String v01) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Common2DTO> vlist = new Vector<Common2DTO>();
		try {
			con = pool.getConnection();
			sql = "select * from Hanrasan02 where s01 = ? and s03 in ('00004', '00005') ";
			//sql = "select * from arduino03 where s01 = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, v01);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Common2DTO bean = new Common2DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setS01(rs.getString("s01"));
				bean.setS02(rs.getString("s02"));
				bean.setS03(rs.getString("s03"));
				bean.setS04(rs.getString("s04"));
				bean.setS05(rs.getString("s05"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// webapp 자료 확인 및 제어를 위한 부분 ===============================================================================
	// 자료 조회 전체(전체 자료 확인하기 위함)
	public Vector<Common2DTO> Arduino_Get2() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Common2DTO> vlist = new Vector<Common2DTO>();
		try {
			con = pool.getConnection();
			//sql = "select * from Hanrasan02 where s01 = 'CC:50:E3:3E:D3:44'  and s03 in ('00004', '00005') ";
			sql = "select * from Hanrasan02 where s01 = 'CC:50:E3:3E:D3:44' ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Common2DTO bean = new Common2DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setS01(rs.getString("s01"));
				bean.setS02(rs.getString("s02"));
				bean.setS03(rs.getString("s03"));
				bean.setS04(rs.getString("s04"));
				bean.setS05(rs.getString("s05"));
				bean.setS06(rs.getString("s06"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// ON OFF 제어값 변경
	public boolean Arduino_Update_Perm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("ONOOO")) {
				sql = "update Hanrasan02 set s05='OFFOO' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				sql = "update Hanrasan02 set s05='ONOOO' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// Android 제어 부분 ===============================================================================
	// 자료 조회 전체
	public Vector<Common1DTO> Android_GetList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Common1DTO> vlist = new Vector<Common1DTO>();
		try {
			con = pool.getConnection();
			sql = "select * from android";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Common1DTO bean = new Common1DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setF01(rs.getString("f01"));
				bean.setF02(rs.getString("f02"));
				bean.setF03(rs.getString("f03"));
				bean.setF04(rs.getString("f04"));
				bean.setF05(rs.getString("f05"));
				bean.setF06(rs.getString("f06"));
				bean.setF07(rs.getString("f07"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 자료 조회 전체(특정값)
	public Vector<Common1DTO> Android_GetList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Common1DTO> vlist = new Vector<Common1DTO>();
		try {
			con = pool.getConnection();
			sql = "select * from android where f01 = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Common1DTO bean = new Common1DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setF01(rs.getString("f01"));
				bean.setF02(rs.getString("f02"));
				bean.setF03(rs.getString("f03"));
				bean.setF04(rs.getString("f04"));
				bean.setF05(rs.getString("f05"));
				bean.setF06(rs.getString("f06"));
				bean.setF07(rs.getString("f07"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 자료 추가
	public boolean Android_Insert(Common1DTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		// 현재 날짜 구하기
		Date nowTime = new Date();
		// 포맷 정의
	    SimpleDateFormat nalja_f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  // 데이터 포맷
		// 포맷 적용
	    //System.out.println(nalja_f.format(nowTime));

		try {
			con = pool.getConnection();
			sql = "insert android (f01,f02,f03,f04,f05,f06,f07) values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF01());
			pstmt.setString(2, bean.getF02());
			pstmt.setString(3, bean.getF03());
			pstmt.setString(4, bean.getF04());
			pstmt.setString(5, bean.getF05());
			pstmt.setString(6, bean.getF06());
			pstmt.setString(7, nalja_f.format(nowTime));
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 회원 정보 수정
	public boolean Android_Update(Common1DTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;

		Date nowTime = new Date();
	    SimpleDateFormat nalja_f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  // 데이터 포맷

		try {
			con = pool.getConnection();
			sql = "update android set f01=?, f02=?, f03=?, f04=?, f05=?, f06=?, f07=? where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF01());
			pstmt.setString(2, bean.getF02());
			pstmt.setString(3, bean.getF03());
			pstmt.setString(4, bean.getF04());
			pstmt.setString(5, bean.getF05());
			pstmt.setString(6, bean.getF06());
			pstmt.setString(7, nalja_f.format(nowTime));
			pstmt.setInt(8, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 회원 정보 삭제
	public boolean Android_Delete(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from android where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// ON OFF 제어값 변경
	public boolean Android_Update_Perm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("ONOOO")) {
				sql = "update arduino03 set s05='OFFOO' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				sql = "update arduino03 set s05='ONOOO' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
