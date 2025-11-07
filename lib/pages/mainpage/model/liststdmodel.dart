class liststd {
	int? cs;
	int? ts;
	int? iss;
	int? it;
	String? name;
	String? email;

	liststd({this.cs, this.ts, this.iss, this.it, this.name, this.email});

	liststd.fromJson(Map<String, dynamic> json) {
		cs = json['cs'];
		ts = json['ts'];
		iss = json['is'];
		it = json['it'];
		name = json['name'];
		email = json['email'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['cs'] = this.cs;
		data['ts'] = this.ts;
		data['is'] = this.iss;
		data['it'] = this.it;
		data['name'] = this.name;
		data['email'] = this.email;
		return data;
	}
}