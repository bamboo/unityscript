/*
0
duck
0
duck
*/
var homeBase = new Array(); 

class HomeBaseVars2 
{ 
	var avatar              : Array; 
	var avatarDuck;
} 

homeBase[0] = new HomeBaseVars2();
homeBase[0].avatar = new Array();
homeBase[0].avatarDuck = new Array();

homeBase[0].avatar.push(0);
homeBase[0].avatarDuck.push("duck");

print(homeBase[0].avatar[0]);
print(homeBase[0].avatarDuck[0]);

// Same with full ducktyping
var homeBaseDuck;
homeBaseDuck = new Array(); 
homeBaseDuck[0] = new HomeBaseVars2();
homeBaseDuck[0].avatar = new Array();
homeBaseDuck[0].avatarDuck = new Array();

homeBaseDuck[0].avatar.push(0);
homeBaseDuck[0].avatarDuck.push("duck");

print(homeBaseDuck[0].avatar[0]);
print(homeBaseDuck[0].avatarDuck[0]);