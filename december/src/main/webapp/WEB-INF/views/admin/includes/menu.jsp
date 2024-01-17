<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
								<div class="">
                                <div class="main-menu-header">
                                    <img class="img-80 img-radius" src="/resources/assets/images/avatar-4.jpg" alt="User-Profile-Image">
                                    <div class="user-details">
                                        <span id="more-details"><sec:authentication property="principal.member.userName" /><i class="fa fa-caret-down"></i></span>
                                    </div>
                                </div>
                                <div class="main-menu-content">
                                    <ul>
                                        <li class="more-details">
                                        	<a href="/"><i class="ti-user"></i>MainPage</a>
                                            <a href="/admin/member/myPage"><i class="ti-user"></i>View Profile</a>
                                            <a href="#!"><i class="ti-settings"></i>Settings</a>
                                            <sec:authorize access="isAuthenticated()">
											<a href="/customLogout"><i class="ti-layout-sidebar-left"></i>Logout</a>
											</sec:authorize>
											<sec:authorize access="isAnonymous()">
											<a href="/customLogin"><i class="ti-layout-sidebar-left"></i>Logout</a>
											</sec:authorize>
                                            
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="pcoded-navigation-label">Left Time</div>
                             <ul class="pcoded-item pcoded-left-item">
                            	<li class="">
                        			<a href="#" class="waves-effect waves-dark">
                                   <span class="pcoded-micon"><i class="fa fa-clock-o"></i><b>D</b></span>
                                   <span id="remain-time" class="pcoded-mtext"></span>
                                   <span class="pcoded-mcaret"></span> 
                                   </a> 
                                </li>
                                </ul>
                              
                             <div class="pcoded-navigation-label">Time</div>
                             <ul class="pcoded-item pcoded-left-item">
                             
                             	<li class="active">
                        			<a href="#" class="waves-effect waves-dark">
                                   <span class="pcoded-micon"><i class="fa fa-calendar"></i><b>D</b></span>
                                   <span id="local-time1" class="pcoded-mtext"></span>
                                   <span class="pcoded-mcaret"></span> 
                                   </a> 
                                </li>
                             	<li class="active">
                        			<a href="#" class="waves-effect waves-dark">
                                   <span class="pcoded-micon"><i class="fa fa-clock-o"></i><b>D</b></span>
                                   <span id="local-time2" class="pcoded-mtext"></span>
                                   <span class="pcoded-mcaret"></span> 
                                   </a> 
                                </li>
                             
                             </ul>
                            <div class="pcoded-navigation-label">Navigation</div>
                            <ul class="pcoded-item pcoded-left-item">
                                <li class="active">
                                    <a href="/admin/" class="waves-effect waves-dark">
                                        <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                                        <span class="pcoded-mtext">대시보드</span>
                                        <span class="pcoded-mcaret"></span>
                                       </a>
                                    
                                </li>
                                <li class="${active == 'diary'? 'active':'' }">
                                    <a href="/admin/accountbook/diary" class="waves-effect waves-dark">
                                        <span class="pcoded-micon"><i class="ti-agenda"></i><b>D</b></span>
                                        <span class="pcoded-mtext">다이어리</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class="${active == 'board'? 'active':'' }">
                                    <a href="/admin/board/list" class="waves-effect waves-dark">
                                        <span class="pcoded-micon"><i class="ti-list"></i><b>D</b></span>
                                        <span class="pcoded-mtext">게시판관리</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class="${active == 'trade'? 'active':'' }">
                                     <a href="/admin/trade/list" class="waves-effect waves-dark">
                                         <span class="pcoded-micon"><i class="ti-money"></i></span>
                                         <span class="pcoded-mtext">거래명세서</span>
                                         <span class="pcoded-mcaret"></span>
                                     </a>
                                </li>
                                  <li class="${active == 'log'? 'active':'' }">
                                     <a href="/admin/log/list" class="waves-effect waves-dark">
                                         <span class="pcoded-micon"><i class="ti-agenda"></i></span>
                                         <span class="pcoded-mtext">업무일지</span>
                                         <span class="pcoded-mcaret"></span>
                                     </a>
                                </li>
                            </ul>
                            
							<div class="pcoded-navigation-label }">UI Element</div>
                            <ul class="pcoded-item pcoded-left-item">
                                <li class="pcoded-hasmenu ${active == 'major' || active == 'member' || active == 'master' || active == 'myCompany' ? 'active pcode-trigger':''}">
                                    <a href="javascript:void(0)" class="waves-effect waves-dark">
                                        <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i><b>BC</b></span>
                                        <span class="pcoded-mtext">기본정보관리</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                    <ul class="pcoded-submenu">
	                                     <li class="${active == 'myCompany'? 'active':'' }">
                                            <a href="/admin/company/myCompany" class="waves-effect waves-dark">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext">회사정보관리</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                        </li>
                                        <li class="${active == 'major'? 'active':'' }">
                                            <a href="/admin/major/list" class="waves-effect waves-dark">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext">메이지정보관리</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                        </li>
                                        <li class="${active == 'master'? 'active':'' }">
                                            <a href="/admin/master/list" class="waves-effect waves-dark">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext">마스터코드관리</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                       </li>
                                         <li class="${active == 'member'? 'active':'' }">
                                            <a href="/admin/member/list" class="waves-effect waves-dark">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext">직원관리</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                       </li>
                                    </ul>
                                </li>
                            </ul>
                            	<div class="pcoded-navigation-label }">UI Element</div>
                            <ul class="pcoded-item pcoded-left-item">
                                <li class="pcoded-hasmenu ${active == 'product' || active == 'master' || active == 'company' ? 'active pcode-trigger':''}">
                                    <a href="javascript:void(0)" class="waves-effect waves-dark">
                                        <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i><b>BC</b></span>
                                        <span class="pcoded-mtext">업무관리</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                    <ul class="pcoded-submenu">
	                                     <li class="${active == 'company'? 'active':'' }">
                                            <a href="/admin/company/list" class="waves-effect waves-dark">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext">납품업체관리</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                        </li>
                                        <li class="${active == 'product'? 'active':'' }">
                                            <a href="/admin/product/list" class="waves-effect waves-dark">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext">물품관리</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                       	</li>         
                                    </ul>
                                </li>
                            </ul>
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            