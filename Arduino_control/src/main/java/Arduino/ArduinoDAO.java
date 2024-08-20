package Arduino;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;


public class ArduinoDAO {

	private DBConnection pool;

	public ArduinoDAO() {
		try {
			pool = DBConnection.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Arduino ===============================================================================
	// 자료 추가
	public boolean Arduino_Save(String v01, String v02, String v03, String v04) {
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
	    //System.out.println(v01 + "  " + v02 + "  " + v03 + "  " + v04);

		try {
			con = pool.getConnection();
			sql = "insert arduino01 (f01,f02,f03,f04,f07) values (?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, v01);
			pstmt.setString(2, v02);
			pstmt.setString(3, v03);
			pstmt.setString(4, v04);
			pstmt.setString(5, nalja_f.format(nowTime));
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}

		return flag;
	}

	
	// 자료 추가
	public boolean Arduino_Insert(Arduino1DTO bean) {
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
			sql = "insert arduino01 (f01,f02,f03,f04,f05,f06,f07) values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF01());
			pstmt.setString(2, bean.getF02());
			pstmt.setString(3, bean.getF03());
			pstmt.setString(4, bean.getF04());
			pstmt.setString(5, bean.getF05());
			pstmt.setString(6, bean.getF07());
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
	
	// 자료 업데이트1
	public boolean Arduino_Update1(Arduino1DTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		// 현재 날짜 구하기
		Date nowTime = new Date();
		// 포맷 정의
		SimpleDateFormat nalja_f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	 //  데이터 포맷
		// 포맷 적용
		//System.out.println(nalja_f.format(nowTime));
		
		try {
			con = pool.getConnection();
			sql = "update arduino02 set f02=?, f03=?, f04=?, f05=?, f07=? where f01='8C:AA:B5:04:3F:71' ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF02());
			pstmt.setString(2, bean.getF03());
			pstmt.setString(3, bean.getF04());
			pstmt.setString(4, bean.getF05());
			pstmt.setString(5, nalja_f.format(nowTime));
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
	
	// 자료 조회 (MAC address) 한 건만 조회 arduino02
	public Arduino1DTO Arduino_Get1(String v01) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Arduino1DTO bean = null;
		
		try {
			con = pool.getConnection();
			sql = "select * from arduino02 where f01=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, v01);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Arduino1DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setF06(rs.getString("f06"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 자료 조회 (MAC address) 여러건 조회
	public Vector<Arduino2DTO> Arduino_Get2(String v01) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Arduino2DTO> vlist = new Vector<Arduino2DTO>();
		try {
			con = pool.getConnection();
			sql = "select * from arduino03 where s01 = ? and s03 in ('00004', '00005')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, v01);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Arduino2DTO bean = new Arduino2DTO();
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}