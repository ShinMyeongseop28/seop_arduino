package Android;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import java.util.Date;
import java.text.SimpleDateFormat;


public class AndroidDAO {

	private DBConnection pool;

	public AndroidDAO() {
		try {
			pool = DBConnection.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Android ===============================================================================
	// 로그인
	public boolean Member_login(String usid, String uspw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usid from 04_android where usid = ? and uspw = ?";
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
	public Android1DTO Member_get(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Android1DTO bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from 04_android where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Android1DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setName(rs.getString("name"));
				bean.setUstel(rs.getString("ustel"));
				bean.setIpdate(rs.getString("ipdate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 자료 조회 전체
	public Vector<Android1DTO> Android_GetList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Android1DTO> vlist = new Vector<Android1DTO>();
		try {
			con = pool.getConnection();
			sql = "select * from 04_android";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Android1DTO bean = new Android1DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setName(rs.getString("name"));
				bean.setUstel(rs.getString("ustel"));
				bean.setIpdate(rs.getString("ipdate"));
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
	public Vector<Android1DTO> Android_GetList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Android1DTO> vlist = new Vector<Android1DTO>();
		try {
			con = pool.getConnection();
			sql = "select * from 04_android where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Android1DTO bean = new Android1DTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setName(rs.getString("name"));
				bean.setUstel(rs.getString("ustel"));
				bean.setIpdate(rs.getString("ipdate"));
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
	public boolean Android_Insert(Android1DTO bean) {
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
			sql = "insert 04_android (usid,uspw,name,ustel,ipdate) values (?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getUspw());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getUstel());
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

	// 회원 정보 수정
	public boolean Android_Update(Android1DTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;

		Date nowTime = new Date();
	    SimpleDateFormat nalja_f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  // 데이터 포맷

		try {
			con = pool.getConnection();
			sql = "update 04_android set usid=?, uspw=?, name=?, ustel=?, ipdate=? where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getUspw());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getUstel());
			pstmt.setString(5, nalja_f.format(nowTime));
			pstmt.setInt(6, bean.getNumb());
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
			sql = "delete from 04_android where numb=?";
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
	
}