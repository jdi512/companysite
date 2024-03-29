console.log("Reply Module...");

var replyService = (function(){
	
	function add(reply, callback){
		
		$.ajax({
			type : 'post',
			url : '/board/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function getList(param, callback, error){
		var bno = param.bno;	
		var page = param.page < 1 ? 1 : param.page;
		
		$.getJSON("/board/replies/pages/" + bno + "/" + page + ".json",
			function(data){
				if(callback){
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			}//fail
		);
	}//function
	
	
	
	function remove(rno, replyer, callback, error){
		
		$.ajax({
			type : 'delete',
			data:JSON.stringify({rno:rno, replyer:replyer}),
			url : '/board/replies/' + rno,
			contentType : "application/json; charset:utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function update(reply, callback, error){
		
		$.ajax({
			type : 'put',
			url : '/board/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function get(rno, callback, error){
		
		$.get('/board/replies/' + rno + '.json', 
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