/*
Wednesday, October 17th
Load Impulse Responses.scd
prm
*/

var cathedral1Path, cathedral2Path;

cathedral1Path = thisProcess.nowExecutingPath.dirname ++ "/impulse responses/cathedral1.wav";
cathedral2Path = thisProcess.nowExecutingPath.dirname ++ "/impulse responses/cathedral2.wav";

// creates dictionary to store impulse responses
~impulse = ( );

// load Cathedral 1 Impulse
{
	var buffer, bufSize;
	buffer = Buffer.read(s, cathedral1Path);
	s.sync;
	bufSize = PartConv.calcBufSize(2048, buffer);
	~impulse[\cathedral1] = Buffer.alloc(s, bufSize, 1);
	s.sync;
	~impulse[\cathedral1].preparePartConv(buffer, 2048);
	buffer.free;
	"Cathedral 1 Impulse Loaded".postln;
}.fork(AppClock);


// load Cathedral 2 Impulse
{
	var buffer, bufSize;
	buffer = Buffer.read(s, cathedral2Path);
	s.sync;
	bufSize = PartConv.calcBufSize(2048, buffer);
	~impulse[\cathedral2] = Buffer.alloc(s, bufSize, 1);
	s.sync;
	~impulse[\cathedral2].preparePartConv(buffer, 2048);
	buffer.free;
	"Cathedral 2 Impulse Loaded".postln;
}.fork(AppClock);



/*
~cathedralOnePath = Document.current.dir ++ "/setup/3.4Cathedral.wav";
~cathedralTwoPath = Document.current.dir ++ "/setup/8.7BigGothicChurch.wav";
(// creates buffers for use in convolution reverbs
~convolutionVerbs = {
	var cathedralOne, c1BufSize, cathedralTwo, c2BufSize;e
	cathedralOne = Buffer.read(s, ~cathedralOnePath);
	cathedralTwo = Buffer.read(s, ~cathedralTwoPath);
	s.sync;
	c1BufSize = PartConv.calcBufSize(2048, cathedralOne);
	~cathedralOne = Buffer.alloc(s, c1BufSize, 1);
	c2BufSize = PartConv.calcBufSize(2048, cathedralTwo);
	~cathedralTwo = Buffer.alloc(s, c2BufSize, 1);
	s.sync;
	~cathedralOne.preparePartConv(cathedralOne, 2048);
	~cathedralTwo.preparePartConv(cathedralTwo, 2048);
	cathedralOne.free;
	cathedralTwo.free;
}.fork(AppClock);
);
*/