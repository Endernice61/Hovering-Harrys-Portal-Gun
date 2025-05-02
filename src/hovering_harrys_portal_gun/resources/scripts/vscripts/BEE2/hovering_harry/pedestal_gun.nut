gun_exist <- 0;
delayRotations <- 0;
rotationQueued <- 0;
reverse <- 0;
isRotating <- 0;

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

function startDelayingRotations(delay) {
	delayRotations <- 1;
	EntFireByHandle(self,"RunScriptCode","endDelayingRotations()",delay.tofloat()/66.0,null,null);
}

function endDelayingRotations() {
	delayRotations <- 0;
	if (rotationQueued == 1) rotate();
}

function rotate() {
	rotationQueued = delayRotations;
	if (rotationQueued == 0) rotateDir();
}

function rotateDir() {
	setRotating(1);
	EntFireByHandle(EntityGroup[3],"Lock","",0,null,null);
	if (reverse) {
		EntFireByHandle(EntityGroup[2],"SetSpeed","-1",0,null,null);
		EntFireByHandle(EntityGroup[2],"Open","",0,null,null);
		EntFireByHandle(EntityGroup[2],"SetSpeed","30",0.01,null,null);
		EntFireByHandle(EntityGroup[1],"Trigger","",0.05,null,null);
		EntFireByHandle(EntityGroup[2],"Close","",0.05,null,null);
	} else {
		EntFireByHandle(EntityGroup[1],"Trigger","",0,null,null);
		EntFireByHandle(EntityGroup[2],"Open","",0,null,null);
		EntFireByHandle(EntityGroup[2],"SetSpeed","-1",3.01,null,null);
		EntFireByHandle(EntityGroup[2],"Close","",3.01,null,null);
		EntFireByHandle(EntityGroup[2],"SetSpeed","30",3.01,null,null);
	}
	EntFireByHandle(self,"RunScriptCode","setRotating(0)",3.08,null,null);
}

function setRotating(state) {
	isRotating <- state;
}

function rotateForward() {
	if (isRotating) return;
	reverse <- 0;
	rotate();
}

function rotateBackward() {
	if (isRotating) return;
	reverse <- 1;
	rotate();
}