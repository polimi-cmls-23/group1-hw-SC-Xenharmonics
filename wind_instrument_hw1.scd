(
SynthDef(\wind_instrument, {
	|
	freq=440, mix=1, room=0.2,
	dur=5, pos=0,
	amp=0.01,
	amp1=0.2, rate1=0, depth1=0.0,
	amp2=0.2, rate2=0, depth2=0,
	amp3=0.2, rate3=0, depth3=0,
	noiseAmp=0.0,

	mute1=1,
	mute2=1,
	mute3=1,

	smooth=2,

	filter_freq=440,
	filter_bw=2.0,
	filter_mul=1.0,

	attack_level=0.0,
	endattack_level=0.4,
	decay_level=0.4,
	sustain_level=0.9,
	release_level=0.0,

	attack_time=0.06,
	decay_time=0.2,
	sustain_time=2,
	release_time=0.2,

	white_noise=0.0,
	pink_noise=0.0,
	brown_noise=0.0,

	out=0
	|
	var sig, env, osc1, osc2, osc3, noise;
	var num = 5;
	var harms = Array.series(num, 1, 1) * Array.exprand(num, 0.995, 1.001);

	env = EnvGen.ar(Env.new(
		[ attack_level, endattack_level, decay_level, sustain_level, release_level], [attack_time, decay_time, sustain_time, release_time], 'linear' ), doneAction:2);


	osc1=SinOsc.ar([freq,freq] * SinOsc.kr(rate1,0,depth1*0.01,1) * harms, mul:Array.geom(num, 1*mute1, amp1*mute1));
	osc2=Saw.ar([freq,freq] * SinOsc.kr(rate2,0,depth2*0.01,1) * harms, mul:Array.geom(num, 1*mute2, amp2*mute2));
	osc3=Pulse.ar([freq,freq] * SinOsc.kr(rate3,0,depth3*0.01,1) * harms, mul:Array.geom(num, 1*mute3, amp3*mute3));

	sig = BBandPass.ar(osc1+osc2+osc3, filter_freq * XLine.kr(0.1,smooth,0.01), filter_bw, filter_mul);
	sig = sig*amp*env;
	white_noise = WhiteNoise.ar(white_noise*0.005);
	pink_noise = PinkNoise.ar(pink_noise*0.01);
	brown_noise = BrownNoise.ar(brown_noise*0.01);
	noise = BBandPass.ar(white_noise + pink_noise + brown_noise, filter_freq * XLine.kr(0.1,smooth,0.01), filter_bw, filter_mul) * env;

	Out.ar(out, (sig+noise)!2);
}).add;
)


a = Synth.new(\wind_instrument);


/////////////////////////////////////////////////////////////////

(
var freqBox, amp_box1, vib_box1, vamp_box1,
amp_box2, vib_box2, vamp_box2,
amp_box3, vib_box3, vamp_box3,
noiseBox, nSliderbox, noiseSlider, noiseAmp, white_button, pink_button, brown_button,
white_noise, pink_noise, brown_noise,
envBox,
attack_level, endattack_level, decay_level, sustain_level, release_level,
start_time, attack_time, decay_time, sustain_time, release_time,
filterBox, filter_freq_box, filter_freq_knob, filter_freq, filter_bw_box, filter_bw_knob, filter_bw,
filter_mul_box, filter_mul_knob, filter_mul, smooth, smooth_box, smooth_knob,
mute1, mute2, mute3,
presetBox, preset, seqBox, playSeq, tSliderbox, tempoSlider,
synth, harm, inst_freq, freq, amp1, amp2, amp3, rate1, depth1, rate2, depth2, rate3, depth3, osc1, osc2, osc3, amp_osc1, amp_osc2, amp_osc3, playStop, vibKnob_f1, vibKnob_amp1, vibKnob_f2, vibKnob_amp2, vibKnob_f3, vibKnob_amp3,
brass, flute, notemute, ampsequencer1, ampsequencer2, ampsequencer3,
note1, note2, note3, note4, note5, note6, tempo, img, seq_time,
b_1_1, b_1_2, b_1_3, b_1_4, b_1_5, b_1_6, b_1_7, b_1_8, b_1_9, b_1_10, b_1_11, b_1_12, b_1_13, b_1_14, b_1_15, b_1_16, b_1_17, b_1_18, b_1_19, b_1_20, b_1_21, b_1_22, b_1_23, b_1_24, b_1_25,
b_2_1, b_2_2, b_2_3, b_2_4, b_2_5, b_2_6, b_2_7, b_2_8, b_2_9, b_2_10, b_2_11, b_2_12, b_2_13, b_2_14, b_2_15, b_2_16, b_2_17, b_2_18, b_2_19, b_2_20, b_2_21, b_2_22, b_2_23, b_2_24, b_2_25,
b_3_1, b_3_2, b_3_3, b_3_4, b_3_5, b_3_6, b_3_7, b_3_8, b_3_9, b_3_10, b_3_11, b_3_12, b_3_13, b_3_14, b_3_15, b_3_16, b_3_17, b_3_18, b_3_19, b_3_20, b_3_21, b_3_22, b_3_23, b_3_24, b_3_25,
b_4_1, b_4_2, b_4_3, b_4_4, b_4_5, b_4_6, b_4_7, b_4_8, b_4_9, b_4_10, b_4_11, b_4_12, b_4_13, b_4_14, b_4_15, b_4_16, b_4_17,  b_4_18, b_4_19, b_4_20, b_4_21, b_4_22, b_4_23, b_4_24, b_4_25,
b_5_1, b_5_2, b_5_3, b_5_4, b_5_5, b_5_6, b_5_7, b_5_8, b_5_9, b_5_10, b_5_11, b_5_12, b_5_13, b_5_14, b_5_15, b_5_16, b_5_17, b_5_18, b_5_19, b_5_20, b_5_21, b_5_22, b_5_23, b_5_24, b_5_25,
b_6_1, b_6_2, b_6_3, b_6_4, b_6_5, b_6_6, b_6_7, b_6_8, b_6_9, b_6_10, b_6_11, b_6_12, b_6_13, b_6_14, b_6_15, b_6_16, b_6_17, b_6_18, b_6_19, b_6_20, b_6_21, b_6_22, b_6_23, b_6_24, b_6_25;

///////// Init Parameters \\\\\\\\\

attack_level=0.8;
endattack_level=0.0;
decay_level=0.4;
sustain_level=0.4;
release_level=0.0;

start_time=0.00;
attack_time=0.06;
decay_time=0.2;
sustain_time=5;
release_time=10;

mute1=1;
mute2=1;
mute3=1;

note1=0;
note2=0;
note3=0;
note4=0;
note5=0;
note6=0;

notemute=0;
ampsequencer1=0;
ampsequencer2=0;
ampsequencer3=0;


img = Image.new(thisProcess.nowExecutingPath.dirname +/+ "wind.png");
///////// MAIN WINDOW \\\\\\\\\

w = FlowView.new(
	bounds: 1125@820,
	margin: 10@10,
	gap: 10@10,
	windowTitle: "Wind Instrument").background_(Color.black(0.6, 0.2));


StaticText.new(w, 1115@50)
	.string_("WIND INSTRUMENT SYNTH")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 30));

w.startRow;

///////// FREQUENCY + PLAY/STOP \\\\\\\\\

harm = FlowView.new(w, 130@220, margin: 10@10).backgroundImage_(img);

StaticText.new(harm, 110@25)
	.string_("FREQUENCY")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

harm.startRow;

amp_box1 = CompositeView(harm, Rect(100, 50, 80, 80))
.background_(Color.grey.alpha_(0));
amp_box1.moveTo(22.5,50);

inst_freq = EZKnob(amp_box1,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(100, 3000, 'lin', 0.01),
	action: {arg me;
		freq = me.value;
		synth.set(\freq , me.value);
		},
	initVal: 440,
	initAction:true
)
.setColors()
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

harm.startRow;

playStop = Button.new(harm, bounds:Rect(0,0,80,30)).states_([
    ["Play", Color.black, Color.grey(0.7)],
	["Stop", Color.red(0.7), Color.grey(0.7)]
]).action_({|b|
	if(b.value == 1)
	{synth = Synth.new(\wind_instrument, [\freq, freq, \amp1, amp1, \rate1, rate1, \depth1, depth1, \amp2, amp2, \rate2, rate2, \depth2, depth2, \amp3, amp3, \rate3, rate3, \depth3, depth3, \white_noise, white_noise, \pink_noise, pink_noise, \brown_noise, brown_noise, \attack_level, attack_level, \decay_level, decay_level, \sustain_level, sustain_level, \release_level, release_level, \attack_time, attack_time, \decay_time, decay_time, \sustain_time, sustain_time, \release_time, release_time,
		\filter_freq, filter_freq, \filter_bw, filter_bw, \filter_mul, filter_mul, \smooth, smooth, \mute1, mute1, \mute2, mute2, \mute3, mute3
	]);}
	{synth.free;}}).font_(Font("Monaco", 14, true));
playStop.moveTo(20, 150);


///////// SINE OSCILLATOR \\\\\\\\\

osc1 = FlowView.new(w, 310@220, margin: 10@10).backgroundImage_(img);

StaticText.new(osc1, 300@30)
	.string_("SINE OSCILLATOR")
	.align_(\top)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 18, true));

osc1.startRow;

/// Labels
StaticText.new(osc1, Rect(0, 10, 90, 50))
	.string_("Amplitude")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

StaticText.new(osc1, Rect(120, 10, 90, 50))
	.string_("Vibrato Freq")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

StaticText.new(osc1, Rect(230, 10, 90, 50))
	.string_("Vibrato Amp")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

osc1.startRow;


/// Amplitude Selection
amp_box1 = CompositeView(osc1, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));

amp_osc1 = EZKnob(amp_box1,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 1, 'lin', 0.01),
	action: {arg me;
		amp1 = me.value;
		if (me.value==0,
			{mute1 = 0},
			{mute1 = 1; synth.set(\amp1 , amp1)})
		},
	initVal: 0.5,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

/// Vibrato Frequency Selection
vib_box1 = CompositeView(osc1, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
vib_box1.moveTo(110,100);

vibKnob_f1 = EZKnob(vib_box1,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 2, 'lin', 0.1),
	action: {arg me;
		rate1 = me.value;
		},
	initVal: 0.0,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

/// Vibrato Amplitude Selection
vamp_box1 = CompositeView(osc1, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
vamp_box1.moveTo(210,100);

vibKnob_amp1 = EZKnob(vamp_box1,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 0.10, 'lin', 0.001),
	action: {arg me;
		depth1 = me.value;
		},
	initVal: 0.00,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

///////// SAW OSCILLATOR \\\\\\\\\

osc2 = FlowView.new(w, 310@220, margin: 10@10).backgroundImage_(img);

StaticText.new(osc2, 300@30)
	.string_("SAW OSCILLATOR")
	.align_(\top)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 18, true));

osc2.startRow;

/// Labels
StaticText.new(osc2, Rect(0, 10, 90, 50))
	.string_("Amplitude")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

StaticText.new(osc2, Rect(120, 10, 90, 50))
	.string_("Vibrato Freq")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

StaticText.new(osc2, Rect(230, 10, 90, 50))
	.string_("Vibrato Amp")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

osc2.startRow;


/// Amplitude Selection
amp_box2 = CompositeView(osc2, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));


amp_osc2 = EZKnob(amp_box2,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 1, 'lin', 0.01),
	action: {arg me;
		amp2 = me.value;
		if (me.value==0,
			{mute2=0;},
			{mute2=1; synth.set(\amp2, amp2);})
		},
	initVal: 0.5,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

/// Vibrato Frequency Selection
vib_box2 = CompositeView(osc2, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
vib_box2.moveTo(110,100);

vibKnob_f2 = EZKnob(vib_box2,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 2, 'lin', 0.1),
	action: {arg me;
		rate2 = me.value;
		},
	initVal: 0.0,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

/// Vibrato Amplitude Selection
vamp_box2 = CompositeView(osc2, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
vamp_box2.moveTo(210,100);

vibKnob_amp2 = EZKnob(vamp_box2,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 2, 'lin', 0.1),
	action: {arg me;
		depth2 = me.value;
		},
	initVal: 0.00,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);


///////// SQUARE OSCILLATOR \\\\\\\\\

osc3 = FlowView.new(w, 310@220, margin: 10@10).backgroundImage_(img);

StaticText.new(osc3, 300@30)
	.string_("SQUARE OSCILLATOR")
	.align_(\top)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 18, true));

osc3.startRow;

/// Labels
StaticText.new(osc3, Rect(0, 10, 90, 50))
	.string_("Amplitude")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

StaticText.new(osc3, Rect(120, 10, 90, 50))
	.string_("Vibrato Freq")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

StaticText.new(osc3, Rect(230, 10, 90, 50))
	.string_("Vibrato Amp")
	.align_(\center)
    .stringColor_(Color.white(0.9, 1))
	.font_(Font("Monaco", 16, true));

osc3.startRow;

/// Amplitude Selection
amp_box3 = CompositeView(osc3, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));

amp_osc3 = EZKnob(amp_box3,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 1, 'lin', 0.01),
	action: {arg me;
		amp3 = me.value;
		if (me.value==0,
			{mute3=0;},
			{mute3=1; synth.set(\amp3, amp3);})

		},
	initVal: 0.5,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

/// Vibrato Frequency Selection
vib_box3 = CompositeView(osc3, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
vib_box3.moveTo(110,100);

vibKnob_f3 = EZKnob(vib_box3,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 2, 'lin', 0.1),
	action: {arg me;
		rate3 = me.value;
		},
	initVal: 0.0,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

/// Vibrato Amplitude Selection
vamp_box3 = CompositeView(osc3, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
vamp_box3.moveTo(210,100);

vibKnob_amp3 = EZKnob(vamp_box3,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 2, 'lin', 0.1),
	action: {arg me;
		depth3 = me.value;
		},
	initVal: 0.00,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);


///////// NOISE - BREATH \\\\\\\\\

noiseBox = FlowView.new(w, 130@220, margin: 10@10).backgroundImage_(img);

StaticText.new(noiseBox, 100@25)
	.string_("NOISE")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

noiseBox.startRow;

white_button = Button.new(noiseBox, bounds:Rect(0,0,80,30)).states_([
    ["White Off", Color.red, Color.white(0.7)],
	["White On", Color.new255(0, 100, 0), Color.white(0.7)]
]).action_({|b|
	if(b.value == 1)
	{white_noise=noiseAmp; pink_noise=0; brown_noise=0; pink_button.value=0; brown_button.value=0;}
	{white_noise=0; pink_noise=0; brown_noise=0;}}).font_(Font("Monaco", 14, true));
white_button.moveTo(25, 35);

noiseBox.startRow;

pink_button = Button.new(noiseBox, bounds:Rect(0,0,80,30)).states_([
    ["Pink Off", Color.red, Color.new255(255, 105, 180),],
	["Pink On", Color.new255(0, 100, 0), Color.new255(255, 105, 180),]
]).action_({|b|
	if(b.value == 1)
	{pink_noise=noiseAmp; white_noise=0; brown_noise=0; white_button.value=0; brown_button.value=0;}
	{white_noise=0; pink_noise=0; brown_noise=0;}}).font_(Font("Monaco", 14, true));
pink_button.moveTo(25, 70);

noiseBox.startRow;

brown_button = Button.new(noiseBox, bounds:Rect(0,0,80,30)).states_([
    ["Brown Off", Color.red, Color.new255(139, 35, 35),],
	["Brown On", Color.new255(0, 100, 0), Color.new255(139, 35, 35),]
]).action_({|b|
	if(b.value == 1)
	{brown_noise=noiseAmp; white_noise=0; brown_noise=0; white_button.value=0; pink_button.value=0;}
	{white_noise=0; pink_noise=0; brown_noise=0;}}).font_(Font("Monaco", 14, true));
brown_button.moveTo(25, 105);

noiseBox.startRow;

nSliderbox = CompositeView(noiseBox, Rect(0, 0, 60, 80))
.background_(Color.grey.alpha_(0));
nSliderbox.moveTo(40,140);

noiseSlider = EZKnob(nSliderbox,
	bounds: Rect(0, 0, 50, 70),
	controlSpec: ControlSpec(0, 1, 'lin', 0.01),
	action: {arg me;
		noiseAmp = me.value;
		if(white_button.value == 1)
		{white_noise=me.value;};
		if(pink_button.value == 1)
		{pink_noise=me.value;};
		if(brown_noise.value == 1)
		{brown_noise=me.value;};
		},
	initVal: 0.0,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);


///////// ADSR ENVELOPE \\\\\\\\\

envBox = FlowView.new(w, 540@220, margin: 10@10).backgroundImage_(img);

StaticText.new(envBox, 530@25)
	.string_("ADSR ENVELOPE")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));


b = EnvelopeView(envBox, Rect(0, 0, 520, 150))
    .drawLines_(true)
    .selectionColor_(Color.red)
    .drawRects_(true)
    .resize_(5)
    .step_(0.05)
    .action_({arg x;
	switch (x.index,
		0,   { start_time=x.value[0][0]; endattack_level=x.value[1][0] },
		1,   { attack_time=x.value[0][1]; attack_level=x.value[1][1] },
		2,   { decay_time=x.value[0][2]; decay_level=x.value[1][2] },
		3,   { sustain_time=x.value[0][3]; sustain_level=x.value[1][3] },
		4,   { release_time=x.value[0][4]; release_level=x.value[1][4] }
);})
    .thumbSize_(5)
    .value_([[start_time, attack_time, decay_time, sustain_time, release_time],[endattack_level, attack_level, decay_level, sustain_level, release_level]]);

// show grid
b.grid = Point(0.2, 0.2);
b.gridOn_(true);


///////// FILTER \\\\\\\\\
filterBox = FlowView.new(w, 400@220, margin: 10@10).backgroundImage_(img);

StaticText.new(filterBox, 390@30)
	.string_("FILTER")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

filterBox.startRow;

/// Labels
StaticText.new(filterBox, Rect(0, 10, 90, 50))
	.string_("Frequency")
    .stringColor_(Color.white(0.9, 1))
	.align_(\center)
	.font_(Font("Monaco", 16, true));

StaticText.new(filterBox, Rect(120, 10, 90, 50))
	.string_("Bandwidth")
    .stringColor_(Color.white(0.9, 1))
	.align_(\center)
	.font_(Font("Monaco", 16, true));

StaticText.new(filterBox, Rect(210, 10, 90, 50))
	.string_("Amplitude")
    .stringColor_(Color.white(0.9, 1))
	.align_(\center)
	.font_(Font("Monaco", 16, true));

StaticText.new(filterBox, Rect(300, 10, 90, 50))
	.string_("Smooth")
    .stringColor_(Color.white(0.9, 1))
	.align_(\center)
	.font_(Font("Monaco", 16, true));

filterBox.startRow;


/// Filter Frequency Selection
filter_freq_box = CompositeView(filterBox, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
filter_freq_box.moveTo(15,90);

filter_freq_knob = EZKnob(filter_freq_box,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: \freq,
	action: {arg me;
		filter_freq = me.value;
		},
	initVal: freq,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);


/// Filter Bandwidth Selection

filter_bw_box = CompositeView(filterBox, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
filter_bw_box.moveTo(110,90);

filter_bw_knob = EZKnob(filter_bw_box,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(1, 10, 'lin', 0.1),
	action: {arg me;
		filter_bw = me.value;
		},
	initVal: 1,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

/// Filter Amplitude Selection

filter_mul_box = CompositeView(filterBox, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
filter_mul_box.moveTo(205,90);


filter_mul_knob = EZKnob(filter_mul_box,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(0, 1, 'lin', 0.1),
	action: {arg me;
		filter_mul = me.value;
		},
	initVal: 1.0,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);


smooth_box = CompositeView(filterBox, Rect(80, 80, 80, 80))
.background_(Color.grey.alpha_(0));
smooth_box.moveTo(300,90);


smooth_knob = EZKnob(smooth_box,
	bounds: Rect(10, 0, 60, 80),
	controlSpec: ControlSpec(1, 10, 'lin', 0.5),
	action: {arg me;
		smooth = me.value;
		},
	initVal: 1.0,
	initAction:true
)
.setColors(Color.blue, Color.white)
.font_(Font("Monaco", 16, true))
.numberView.align_(\center);

///////// PRESET \\\\\\\\\
presetBox = FlowView.new(w, 130@220, margin: 10@10).backgroundImage_(img);

StaticText.new(presetBox, 120@30)
	.string_("PRESET")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

presetBox.startRow;


brass = Button.new(presetBox, bounds:Rect(0,0,110,30)).states_([
    ["Brass", Color.black, Color.grey(0.7)],
	["Stop", Color.red(0.7), Color.grey(0.7)]
]).action_({|b|
	if(b.value == 1)
	{flute.value=0; synth.free; synth = Synth.new(\wind_instrument, [\freq, freq, \amp1, 0.63, \rate1, 1, \depth1, 0.02, \amp2, 0, \rate2, 0, \depth2, 0, \amp3, 0, \rate3, 0, \depth3, 0, \noiseAmp, 0, \attack_level, attack_level, \decay_level, decay_level, \sustain_level, 0.5, \release_level, release_level, \attack_time, attack_time, \decay_time, decay_time, \sustain_time, sustain_time, \release_time, release_time,
			\filter_freq, filter_freq, \filter_bw, 2, \filter_mul, 1, \smooth, 7, \mute2, 0, \mute3, 0, \pink_noise, 0.13
	]);}
	{synth.free;}}).font_(Font("Monaco", 14, true));
brass.moveTo(10, 60);


presetBox.startRow;


flute = Button.new(presetBox, bounds:Rect(0,0,110,30)).states_([
    ["Flute", Color.black, Color.grey(0.7)],
	["Stop", Color.red(0.7), Color.grey(0.7)]
]).action_({|b|
	if(b.value == 1)
	{brass.value=0; synth.free; synth = Synth.new(\wind_instrument, [\freq, freq, \room, 0.5, \amp1, 0.0, \rate1, 0, \depth1, 0, \amp2, 0.5, \rate2, 0, \depth2, 0.0, \amp3, 0.5, \rate3, 1, \depth3, 0.05, \noiseAmp, 0.1, \attack_level, attack_level, \decay_level, 0.3, \sustain_level, 0.4, \release_level, 0.0, \attack_time, 0.2, \decay_time, 0.2, \sustain_time, 2, \release_time, 2, \white_noise, 0.16,
		\filter_freq, 1000, \filter_bw, 2, \filter_mul, 1, \smooth, 1, \mute1, 0, \mute2, 1, \mute3, 1
	]);}
	{synth.free;}}).font_(Font("Monaco", 14, true));
flute.moveTo(10, 100);


///////// SEQUENCER \\\\\\\\\

seqBox = FlowView.new(w, 720@220, margin: 10@12).backgroundImage_(img);

StaticText.new(seqBox, 700@20)
	.string_("SEQUENCER")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

a = StaticText.new(seqBox, 10@20)
	.string_("A")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(135, 40);

a = StaticText.new(seqBox, 18@20)
	.string_("A#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(155, 40);

a = StaticText.new(seqBox, 18@20)
	.string_("B")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(175, 40);

a = StaticText.new(seqBox, 18@20)
	.string_("C")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(197, 40);

a = StaticText.new(seqBox, 18@20)
	.string_("C#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(220, 40);

a = StaticText.new(seqBox, 18@20)
	.string_("D")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(240, 40);

a = StaticText.new(seqBox, 18@20)
	.string_("D#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(265, 40);


a = StaticText.new(seqBox, 18@20)
	.string_("E")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(285, 40);

a = StaticText.new(seqBox, 18@20)
	.string_("F")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(307, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("F#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(330, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("G")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(352, 40);

a = StaticText.new(seqBox, 19@20)
    .string_("G#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(375, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("A")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(395, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("A#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(420, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("B")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(440, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("B#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(460, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("C")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(482, 40);

a = StaticText.new(seqBox, 19@20)
    .string_("C#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(505, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("D")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(525, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("D#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(550, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("E")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(570, 40);


a = StaticText.new(seqBox, 18@20)
    .string_("F")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(590, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("F#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(615, 40);

a = StaticText.new(seqBox, 18@20)
    .string_("G")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(638, 40);

a = StaticText.new(seqBox, 19@20)
    .string_("G#")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 14));
a.moveTo(660, 40);






seqBox.startRow;

StaticText.new(seqBox, 100@19)
	.string_("Note 1")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));


//// note 1 seq

b_1_1 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=1; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_1.moveTo(130, 62);

b_1_2 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=2; b_1_1.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_2.moveTo(152, 62);


b_1_3 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=3; b_1_1.value=0; b_1_2.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_3.moveTo(174, 62);

b_1_4 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=4; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_4.moveTo(196, 62);


b_1_5 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=5; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_5.moveTo(218, 62);

b_1_6 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=6; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_6.moveTo(240, 62);

b_1_7 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=7; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_7.moveTo(262, 62);

b_1_8 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=8; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_8.moveTo(284, 62);

b_1_9 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=9; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_9.moveTo(306, 62);

b_1_10 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=10; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_10.moveTo(328, 62);

b_1_11 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=11; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_11.moveTo(350, 62);

b_1_12 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=12; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_12.moveTo(372, 62);

b_1_13 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=13; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_13.moveTo(394, 62);

b_1_14 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=14; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_14.moveTo(416, 62);

b_1_15 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=15; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_15.moveTo(438, 62);

b_1_16 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=16; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_16.moveTo(460, 62);

b_1_17 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=17; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_17.moveTo(482, 62);


b_1_18 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=18; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_18.moveTo(504, 62);


b_1_19 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=19; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_19.moveTo(526, 62);


b_1_20 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=20; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_20.moveTo(548, 62);


b_1_21 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=21; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_21.moveTo(570, 62);


b_1_22 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=22; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_23.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_22.moveTo(592, 62);


b_1_23 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=23; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_24.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_23.moveTo(614, 62);


b_1_24 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=24; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_24.moveTo(636, 62);


b_1_25 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.green(0.7), Color.green(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note1=25; b_1_1.value=0; b_1_2.value=0; b_1_3.value=0; b_1_4.value=0; b_1_5.value=0; b_1_6.value=0; b_1_7.value=0; b_1_8.value=0; b_1_9.value=0; b_1_10.value=0; b_1_11.value=0; b_1_12.value=0; b_1_13.value=0; b_1_14.value=0; b_1_15.value=0; b_1_16.value=0; b_1_17.value=0; b_1_18.value=0; b_1_19.value=0; b_1_20.value=0; b_1_21.value=0; b_1_22.value=0; b_1_23.value=0; b_1_24.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_1_25.moveTo(658, 62);


seqBox.startRow;

StaticText.new(seqBox, 100@19)
	.string_("Note 2")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));


//// seg note 2

b_2_1 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=1; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_1.moveTo(130, 86);

b_2_2 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=2; b_2_1.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_2.moveTo(152, 86);


b_2_3 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=3; b_2_1.value = 0; b_2_2.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_3.moveTo(174, 86);

b_2_4 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=4; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_4.moveTo(196, 86);


b_2_5 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=5; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_5.moveTo(218, 86);

b_2_6 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=6; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_6.moveTo(240, 86);

b_2_7 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=7; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_7.moveTo(262, 86);

b_2_8 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=8; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_8.moveTo(284, 86);

b_2_9 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=9; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_9.moveTo(306, 86);

b_2_10 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=10; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_10.moveTo(328, 86);

b_2_11 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=11; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_11.moveTo(350, 86);

b_2_12 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=12; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_12.moveTo(372, 86);

b_2_13 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=13; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0;  b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_13.moveTo(394, 86);

b_2_14 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=14; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_14.moveTo(416, 86);

b_2_15 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=15; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_15.moveTo(438, 86);

b_2_16 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=16; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_16.moveTo(460, 86);

b_2_17 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=17; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_17.moveTo(482, 86);


b_2_18 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=18; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_18.moveTo(504, 86);


b_2_19 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=19; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_19.moveTo(526, 86);


b_2_20 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=20; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_20.moveTo(548, 86);


b_2_21 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=21; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_21.moveTo(570, 86);


b_2_22 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=22; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_23.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_22.moveTo(592, 86);


b_2_23 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=23; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_24.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_23.moveTo(614, 86);


b_2_24 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=24; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_24.moveTo(636, 86);


b_2_25 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.yellow(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note2=25; b_2_1.value = 0; b_2_2.value=0; b_2_3.value=0; b_2_4.value=0; b_2_5.value=0; b_2_6.value=0; b_2_7.value=0; b_2_8.value=0; b_2_9.value=0; b_2_10.value=0; b_2_11.value=0; b_2_12.value=0; b_2_13.value=0; b_2_14.value=0; b_2_15.value=0; b_2_16.value=0; b_2_17.value=0; b_2_18.value=0; b_2_19.value=0; b_2_20.value=0; b_2_21.value=0; b_2_22.value=0; b_2_23.value=0; b_2_24.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_2_25.moveTo(658, 86);

seqBox.startRow;


////////////////////// note 3 seq

StaticText.new(seqBox, 100@19)
	.string_("Note 3")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

b_3_1 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=1; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_1.moveTo(130, 109);

b_3_2 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=2; b_3_1.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_2.moveTo(152, 109);


b_3_3 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=3; b_3_1.value=0; b_3_2.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_3.moveTo(174, 109);

b_3_4 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=4; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_4.moveTo(196, 109);


b_3_5 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=5; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_5.moveTo(218, 109);

b_3_6 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=6; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_6.moveTo(240, 109);

b_3_7 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=7; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0;  b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_7.moveTo(262, 109);

b_3_8 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=8; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_8.moveTo(284, 109);

b_3_9 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=9; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0;  b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_9.moveTo(306, 109);

b_3_10 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=10; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0;  b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_10.moveTo(328, 109);

b_3_11 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=11; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_11.moveTo(350, 109);

b_3_12 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=12; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_12.moveTo(372, 109);

b_3_13 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=13; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_13.moveTo(394, 109);

b_3_14 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=14; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_14.moveTo(416, 109);

b_3_15 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=15; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0;  b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_15.moveTo(438, 109);

b_3_16 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=16; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0;  b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_16.moveTo(460, 109);

b_3_17 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=17; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0;  b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_17.moveTo(482, 109);


b_3_18 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=18; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0;  b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_18.moveTo(504, 109);


b_3_19 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=19; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0;  b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_19.moveTo(526, 109);


b_3_20 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=20; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0;  b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_20.moveTo(548, 109);


b_3_21 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=21; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0;  b_3_22.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_21.moveTo(570, 109);


b_3_22 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=22; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_23.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_22.moveTo(592, 109);


b_3_23 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=23; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_24.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_23.moveTo(614, 109);


b_3_24 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=24; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_24.moveTo(636, 109);


b_3_25 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.red(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note3=25; b_3_1.value=0; b_3_2.value=0; b_3_3.value=0; b_3_4.value=0; b_3_5.value=0; b_3_6.value=0; b_3_7.value=0; b_3_8.value=0; b_3_9.value=0; b_3_10.value=0; b_3_11.value=0; b_3_12.value=0; b_3_13.value=0; b_3_14.value=0; b_3_15.value=0; b_3_16.value=0; b_3_17.value=0; b_3_18.value=0; b_3_19.value=0; b_3_20.value=0; b_3_21.value=0; b_3_22.value=0; b_3_23.value=0; b_3_24.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_3_25.moveTo(658, 109);

seqBox.startRow;

StaticText.new(seqBox, 100@19)
	.string_("Note 4")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

////////////////// note 4 seq


b_4_1 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=1; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_1.moveTo(130, 132.5);

b_4_2 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=2; b_4_1.value=0;  b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_2.moveTo(152, 132.5);


b_4_3 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=3; b_4_1.value=0; b_4_2.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_3.moveTo(174, 132.5);

b_4_4 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=4; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_4.moveTo(196, 132.5);


b_4_5 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=5; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_5.moveTo(218, 132.5);

b_4_6 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=6; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_6.moveTo(240, 132.5);

b_4_7 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=7; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_7.moveTo(262, 132.5);

b_4_8 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=8; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_8.moveTo(284, 132.5);

b_4_9 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=9; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_9.moveTo(306, 132.5);

b_4_10 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=10; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_10.moveTo(328, 132.5);

b_4_11 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=11; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0;  b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_11.moveTo(350, 132.5);

b_4_12 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=12; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0;  b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_12.moveTo(372, 132.5);

b_4_13 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=13; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0;  b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_13.moveTo(394, 132.5);

b_4_14 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=14; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_14.moveTo(416, 132.5);

b_4_15 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=15; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_15.moveTo(438, 132.5);

b_4_16 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=16; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_16.moveTo(460, 132.5);

b_4_17 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=17; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_17.moveTo(482, 132.5);


b_4_18 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=18; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0;  b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_18.moveTo(504, 132.5);


b_4_19 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=19; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_19.moveTo(526, 132.5);


b_4_20 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=20; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0;  b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_20.moveTo(548, 132.5);


b_4_21 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=21; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_21.moveTo(570, 132.5);


b_4_22 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=22; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_23.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_22.moveTo(592, 132.5);


b_4_23 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=23; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_24.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_23.moveTo(614, 132.5);


b_4_24 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=24; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_24.moveTo(636, 132.5);


b_4_25 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.magenta(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note4=25; b_4_1.value=0; b_4_2.value=0; b_4_3.value=0; b_4_4.value=0; b_4_5.value=0; b_4_6.value=0; b_4_7.value=0; b_4_8.value=0; b_4_9.value=0; b_4_10.value=0; b_4_11.value=0; b_4_12.value=0; b_4_13.value=0; b_4_14.value=0; b_4_15.value=0; b_4_16.value=0; b_4_17.value=0; b_4_18.value=0; b_4_19.value=0; b_4_20.value=0; b_4_21.value=0; b_4_22.value=0; b_4_23.value=0; b_4_24.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_4_25.moveTo(658, 132.5);

seqBox.startRow;

///////////////////////////// note 5
StaticText.new(seqBox, 100@19)
	.string_("Note 5")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

b_5_1 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=1;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_1.moveTo(130, 156);


b_5_2 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=2; b_5_1.value=0;
  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_2.moveTo(152, 156);


b_5_3 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=3; b_5_1.value=0;
  b_5_2.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_3.moveTo(174, 156);

b_5_4 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=4; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;   b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_4.moveTo(196, 156);


b_5_5 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=5; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;   b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_5.moveTo(218, 156);

b_5_6 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=6; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;    b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_6.moveTo(240, 156);

b_5_7 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=7; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_7.moveTo(262, 156);

b_5_8 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=8; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_8.moveTo(284, 156);

b_5_9 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=9; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_9.moveTo(306, 156);

b_5_10 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=10; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_10.moveTo(328, 156);

b_5_11 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=11; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_11.moveTo(350, 156);

b_5_12 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=12; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_12.moveTo(372, 156);

b_5_13 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=13; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_14.value=0;
		b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_13.moveTo(394, 156);

b_5_14 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=14; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_14.moveTo(416, 156);

b_5_15 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=15; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_15.moveTo(438, 156);

b_5_16 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=16; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_16.moveTo(460, 156);

b_5_17 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=17; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_17.moveTo(482, 156);


b_5_18 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=18; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_18.moveTo(504, 156);


b_5_19 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=19; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_19.moveTo(526, 156);


b_5_20 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=20; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_20.moveTo(548, 156);


b_5_21 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=21; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_21.moveTo(570, 156);


b_5_22 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=22; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_23.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_22.moveTo(592, 156);


b_5_23 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=23; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_24.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_23.moveTo(614, 156);


b_5_24 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=24; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_24.moveTo(636, 156);


b_5_25 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.blue(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note5=25; b_5_1.value=0;
  b_5_2.value=0;  b_5_3.value=0;  b_5_4.value=0;  b_5_5.value=0;  b_5_6.value=0;  b_5_7.value=0;
  b_5_8.value=0;  b_5_9.value=0;  b_5_10.value=0; b_5_11.value=0; b_5_12.value=0; b_5_13.value=0;
  b_5_14.value=0; b_5_15.value=0; b_5_16.value=0; b_5_17.value=0; b_5_18.value=0; b_5_19.value=0;
  b_5_20.value=0; b_5_21.value=0; b_5_22.value=0; b_5_23.value=0; b_5_24.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_5_25.moveTo(658, 156);


seqBox.startRow;

StaticText.new(seqBox, 100@19)
    .string_("Note 6")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 17, true));

b_6_1 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=1;  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_1.moveTo(130, 180);


b_6_2 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    [" ", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=2; b_6_1.value=0;
  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_2.moveTo(152, 180);


b_6_3 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=3; b_6_1.value=0;
  b_6_2.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_3.moveTo(174, 180);

b_6_4 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=4; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;   b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_4.moveTo(196, 180);


b_6_5 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=5; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;   b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_5.moveTo(218, 180);

b_6_6 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=6; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;    b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_6.moveTo(240, 180);

b_6_7 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=7; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_7.moveTo(262, 180);

b_6_8 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=8; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_8.moveTo(284, 180);

b_6_9 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=9; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_9.moveTo(306, 180);

b_6_10 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=10; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_10.moveTo(328, 180);

b_6_11 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=11; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_11.moveTo(350, 180);

b_6_12 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=12; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_12.moveTo(372, 180);

b_6_13 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=13; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_14.value=0;
		b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_13.moveTo(394, 180);

b_6_14 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=14; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_14.moveTo(416, 180);

b_6_15 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=15; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_15.moveTo(438, 180);

b_6_16 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=16; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_16.moveTo(460, 180);

b_6_17 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=17; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_17.moveTo(482, 180);


b_6_18 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=18; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_18.moveTo(504, 180);


b_6_19 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=19; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0; 
})});
b_6_19.moveTo(526, 180);


b_6_20 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=20; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0; 
})});
b_6_20.moveTo(548, 180);


b_6_21 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=21; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0; 
})});
b_6_21.moveTo(570, 180);


b_6_22 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=22; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_23.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0; 
})});
b_6_22.moveTo(592, 180);


b_6_23 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=23; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_24.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0; 
})});
b_6_23.moveTo(614, 180);


b_6_24 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{ampsequencer1=amp1; ampsequencer2=amp2; ampsequencer3=amp3; notemute=1; note6=24; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_25.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;  
})});
b_6_24.moveTo(636, 180);


b_6_25 = Button.new(seqBox, bounds:Rect(0,0,20,20)).states_([
    ["", Color.black, Color.grey(0.7)],
	["", Color.red(0.7), Color.cyan(0.7)]
]).font_(Font("Monaco", 14, true))
.action_({|b|
	if (b.value == 1,
	{notemute=1; note6=25; b_6_1.value=0;
  b_6_2.value=0;  b_6_3.value=0;  b_6_4.value=0;  b_6_5.value=0;  b_6_6.value=0;  b_6_7.value=0;
  b_6_8.value=0;  b_6_9.value=0;  b_6_10.value=0; b_6_11.value=0; b_6_12.value=0; b_6_13.value=0;
  b_6_14.value=0; b_6_15.value=0; b_6_16.value=0; b_6_17.value=0; b_6_18.value=0; b_6_19.value=0;
  b_6_20.value=0; b_6_21.value=0; b_6_22.value=0; b_6_23.value=0; b_6_24.value=0;}, {notemute=1; ampsequencer1=0; ampsequencer2=0; ampsequencer3=0;   
})});
b_6_25.moveTo(658, 180);


seq_time = FlowView.new(w, 220@220, margin: 10@12).backgroundImage_(img);

StaticText.new(seq_time, 200@20)
	.string_("TIME")
    .stringColor_(Color.white(0.9, 1))
	.align_(\top)
	.font_(Font("Monaco", 18, true));

seq_time.startRow;

tSliderbox = CompositeView(seq_time, Rect(0, 0, 30, 150))
.background_(Color.grey.alpha_(0));
tSliderbox.moveTo(100,50);

tempoSlider = EZSlider.new(tSliderbox,Rect(0, 0, 20, 120),
	layout: \vert,
	controlSpec: ControlSpec(0.1, 2, 'lin', 0.1),
	action: {arg me;
		tempo = me.value;
		},
	initVal: 0.5,
	initAction:true
);

seq_time.startRow;

playSeq = Button.new(seq_time, bounds:Rect(0,0,80,30

)).states_([
    ["Play", Color.black, Color.grey(0.7)],
	["Stop", Color.red(0.7), Color.grey(0.7)]
]).action_({|b|
	if(b.value == 1,
		{p = Pseq([note1, note2, note3, note4, note5, note6], inf).asStream; {
inf.do{
	c = Synth(\wind_instrument, [\freq, (p.next+68).midicps, \amp1, ampsequencer1, \rate1, rate1, \depth1, depth1, \amp2, ampsequencer2, \rate2, rate2, \depth2, depth2, \amp3, ampsequencer3, \rate3, rate3, \depth3, depth3, \white_noise, white_noise, \pink_noise, pink_noise, \brown_noise, brown_noise, \attack_level, attack_level, \decay_level, decay_level, \sustain_level, sustain_level, \release_level, release_level, \attack_time, attack_time, \decay_time, decay_time, \sustain_time, sustain_time, \release_time, release_time,
		\filter_freq, filter_freq, \filter_bw, filter_bw, \filter_mul, filter_mul, \smooth, smooth, \mute1, mute1, \mute2, mute2, \mute3, mute3
	]) ; (tempo).wait ;
		}}.fork;},
		{p.stop;c.free;})}).font_(Font("Monaco", 14, true));
playSeq.moveTo(70, 180);

w.onClose = {s.freeAll;};

)


