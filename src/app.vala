using Valum;
using Valum.ContentNegotiation;
using VSGI;

public int main (string[] args) {
	var app = new Router ();

	app.use (basic ());

	app.use (accept ("text/plain"));

	app.get ("/", (req, res) => {
		return res.expand_utf8 ("Hello world!");
	});

	TlsCertificate tls_certificate;
	try {
		tls_certificate = new TlsCertificate.from_files ("cert.pem",
		                                                 "key.pem");
	} catch (Error err) {
		critical (err.message);
		return 1;
	}

	return Server.@new ("http", handler: app, https: true, tls_certificate: tls_certificate).run (args);
}
