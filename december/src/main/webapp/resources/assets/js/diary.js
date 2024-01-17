console.log("Diary Module...");

var diaryService = (function(){
	
	function add(diary, callback){
		
		$.ajax({
			type : 'post',
			url : '/admin/diaries/new',
			data : JSON.stringify(diary),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function getList(callback, error){
				
		$.getJSON("/admin/diaries/month.json",
			function(data){
				if(callback){
					callback(data);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			}//fail
		);
	}//function
	
	
	
	function remove(dno, callback, error){
		
		$.ajax({
			type : 'delete',
			data:JSON.stringify({dno:dno}),
			url : '/admin/diaries/' + dno,
			contentType : "application/json; charset:utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function update(diary, callback, error){
		
		$.ajax({
			type : 'put',
			url : '/admin/diaries/' + diary.dno,
			data : JSON.stringify(diary),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function get(dno, callback, error){
		
		$.get('/admin/diaries/' + dno + '.json', 
			function(data, status, xhr){
				if(data){
					callback(data);
				}
			})
			.fail(function(xhr, status, err){
				if(error){
					error();
				}
			}
		);
		
	}
	
	function displayTime(timeValue){
		var today = new Date();//현재 날짜와시간
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		
		if(gap < (60*60*24*1000)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [
					(hh > 9 ? '':'0') + hh,
					':',
					(mi > 9 ? '':'0') + mi,
					':',
					(ss > 9 ? '':'0') + ss
					].join("");
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [yy,
					'/',
					(mm > 9 ? '':'0') + mm,
					'/',
					(dd > 9 ? '':'0') + dd
					].join("");
		}
	}
	
	function displayBr(textValue){
		
		return textValue.replaceAll("\n", "<br>");
	}
	
	
	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime,
		displayBr:displayBr
	};
})();