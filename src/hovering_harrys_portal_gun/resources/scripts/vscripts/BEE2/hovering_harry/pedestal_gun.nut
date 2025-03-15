gun_exist <- 0;
rotationDelay <- 0;
waitForRotate <- 0;

function trackGun() {
	gun <- Entities.FindByNameNearest(EntityGroup[0].GetName()+"_gun",self.GetCenter(),32);
	EntFireByHandle(gun,"SetParent",EntityGroup[0].GetName(),0,null,null);
	gun_exist <- 1;
}

function killGun() {
	if (gun_exist) EntFireByHandle(gun,"Kill","",0,null,null);
	gun_exist <- 0;
}

function firePortal1() {
	if (gun_exist) EntFireByHandle(gun,"FirePortal1","",0,player,player);
}

function firePortal2() {
	if (gun_exist) EntFireByHandle(gun,"FirePortal2","",0,player,player);
}

function reparent() {
	if (gun_exist) EntFireByHandle(gun,"SetParent",EntityGroup[0].GetName(),0,null,null);
}

function setRotationDelay(delay) {
	rotationDelay <- 1;
	EntFireByHandle(self,"RunScriptCode","removeRotationDelay()",delay.tofloat()/66.0,null,null);
}

function removeRotationDelay() {
	rotationDelay <- 0;
	if (waitForRotate == 1) rotate();
}

function rotate() {
	waitForRotate = rotationDelay;
	if (waitForRotate == 0) EntFireByHandle(EntityGroup[1],"Trigger","",0,null,null);
}