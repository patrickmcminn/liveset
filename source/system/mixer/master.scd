/*
Thursday, June 13th 2013
master.scd
prm
*/

~mixer = ( );


~mixer.master = (

	init: { | self |
		self.makeBuffers;
		self.makeBusses;
		self.makeSynths;

	},

	kill: { | self |
		self.killBuffers;
		self.killBusses;
		self.killSynths;

	},

	makeBuffers: { | self |

	},

	killBuffers: { | self |

	},

	makeBusses: { | self |

	},

	killBusses: { | self |

	},

	makeSynths: { | self |

	},

	killSynths: { | self |

	},
);