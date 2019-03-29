//using GLib;
using Valum;
using Valum.ContentNegotiation;
using VSGI;

public int main (string[] args) {
	var app = new Router ();

	app.use (basic ());

	app.use (accept ("text/plain"));
	app.use (accept_charset ("UTF-8"));

	app.get ("/", (req, res) => {
		return res.expand_utf8 ("Hello world!");
	});

	TlsCertificate tls_certificate;
	try {
		tls_certificate = new TlsCertificate.from_files ("cert.pem",
			                                         "key.pem");
	} catch (Error err) {
		assert_not_reached ();
	}

	return Server.@new ("http", https: true, tls_certificate: tls_certificate, handler: app).run (args);

	//return Server.@new ("http", handler: app).run (args);
}
