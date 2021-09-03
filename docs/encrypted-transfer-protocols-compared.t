#include "doctype.t"
<head><title>Encrypted Transfer Protocols Compared</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

Related: <a href="ftp-vs-http.html">FTP vs HTTP</a>, <a href="curl-vs-wget.html">curl vs wget</a> and <a href="bittorrent-vs-http.html">bittorrent vs HTTP</a>
<p>

TITLE(Encrypted Transfer Protocols Compared)
<p>

 <a href="http://curl.haxx.se/">curl</a> supports a wide variety of
 protocols. Subsequently people who use curl get to chose which protocol to
 use based on other criterias. So how exactly do the various encrypted
 transfer protocols compare?

<p>
 This document describes and compares SCP, SFTP, HTTPS and FTPS and it
 considers both upload and download, as none of the protocols differ very much
 for transports done in either direction.

<p>

SUBTITLE(SSH - SCP and SFTP)
<p>
 SSH (<a href="http://www.ietf.org/rfc/rfc4251.txt">RFC4251</a>) is not
 drastically different than SSL on the lowest transport layer, where the
 actual encryption of the data is made. Block by block is encrypted with a key
 using a negotiated algorithm.

<p> SSH uses no certificates and there's no CAs or chain of trust based on
 certs.  In SSH you trust the hosts for which you have a known public key. And
 you know that key because you connected to the host before, or you got it
 sent to you.

<p> The SSH based protocols do suffer when used on high latency high bandwidth
 networks compared to SSL based ones, due to the packet-back-and-forth
 concepts.

<p> There's a surprising lack of libraries for SSH. <a
  href="http://www.libssh2.org/">libssh2</a> and <a
  href="http://www.libssh.org/">libssh</a> being exceptions.

<p>
 <b>SCP</b>
 <ul>
  <li> Simply a pipe over SSH. This requires that there's a scp command on the
       remote host that supports the exact options the local clients assumes it
       does. Which thus means virtually no portability.
 </ul>
<p>
 <b>SFTP</b>
 <ul>
   <li> A sub protocol over SSH basically providing a full set of fs
        primitives. Exists in many versions, but most clients and servers don't
        implement much of the most recent ones.

   <li> Not at all similar to FTP (except the name), and is only using the
        single TCP connection.

   <li> The actual transfer of a single file is a bit ineffective
        network-wise, since you need to request chunk-by-chunk and get a
        response with status back. There's no "give me the entire file"
        approach. As a result, you need to make a more complicated approach to
        send out multiple outstanding requests to keep the pipe saturated and
        thus achieve maximum throughput.

   <li> Not an RFC yet, only an expired <a
 href="http://tools.ietf.org/id/draft-ietf-secsh-filexfer-13.txt">draft</a>
 exists!
  </ul>

SUBTITLE(SSL - HTTPS and FTPS)
<p> SSL is basically about encrypting the data using a negotiated
  algorithm. It features a trust concept with certificates, where clients
  decide to trust servers to be who they claim to be on the basis that their
  certificates are signed by Certificate Authority that the client trusts. The
  use of cacerts is <a
  href="https://daniel.haxx.se/blog/2008/10/20/in-the-middle-there-is-a-man/">widely
  misunderstood or even misused</a>.

<p> The differences between FTPS and HTTPS are pretty much the exact same
  differences as between <a href="ftp-vs-http.html">FTP and HTTP</a>. The SSL
  part just makes the data streams being encrypted by the sending end.

<p> There's a wide range of mature and good libs (<a
  href="http://www.openssl.org/">OpenSSL</a>, <a
  href="http://www.gnutls.org/">GnuTLS</a>, <a
  href="http://www.mozilla.org/projects/security/pki/nss/">NSS</a>, <a
  href="http://www.yassl.com/">(C)yaSSL</a>, <a
  href="http://www.matrixssl.org/">MatrixSSL</a>, ...) that help apps do
  SSL/TLS easily.

<p>
<b>FTPS</b>
<ul>
 <li> FTPS is FTP that either starts out using SSL already from the start (so
  called implicit FTPS), or it "upgrades" its connection to use SSL (known as
  explicit FTPS).

 <li> A common problem with FTPS is that since the control connection is
  encrypted, stateful firewalls that are otherwise often used for plain FTP to
  allow for the second data connection (remember that it opens up that
  connection dynamicly to a non-fixed port number) can't figure out what port
  number or network address it wants to use.

 <li> Suffers from the fact that it was made into a proper standard spec (<a
  href="http://www.faqs.org/rfcs/rfc4217.html">RFC4217</a>) only recently -
  October 2005.
</ul>

<b>HTTPS</b>
<ul>

 <li> Most widely used out of these quite possibly because this is the primary
  encrypted protocol supported by all major and minor web browsers.

 <li> Due to it being "secure" HTTP, it was designed to be proxied over a HTTP
      proxy fine.

</ul>

SUBTITLE(Encrypted p2p networks)
<p>
 A related area is encrypted p2p networking protocols. I've yet to research
 and learn about what's available and how they work before they can be added
 to this comparison in any good fashion. Please tell me if you have insight
 knowledge. Links: <a href="http://anomos.info/">Anomos</a>.

SUBTITLE(Thanks)
<p>
  Feedback and improvements by: Tomas Salfischberger, Joe Born

BOXBOT
<p>
Updated: __TODAY__ __NOW__ (Central European, Stockholm Sweden)

#include "footer.t"
