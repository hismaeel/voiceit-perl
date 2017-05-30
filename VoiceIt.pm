package VoiceIt;
use strict;
use Digest::SHA qw(sha256_hex);
require HTTP::Request;
require LWP::UserAgent;
my $self;

sub get_filedata {
  my $filename = $_[0];
  open(INFO, $filename);
  my @lines = <INFO>;
  close(INFO);
  my $string = "";
  foreach (@lines){
   $string .= $_;
  }
 return $string;
}

sub new {
  my $package = shift;
  my ( $devID ) = @_;
  $self = bless({devID => $devID, platformId => 22}, $package);
  return $self;
}

sub createUser {
    shift;
    my ($userId, $passwd) = @_;
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/users';
    my $request = HTTP::Request->new(POST=>$url);
    $request->header('Accept' => 'application/json');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('PlatformID' => $self->{platformId});
    my $reply = $ua->request($request);
    return $reply->content();
}

sub getUser {
    shift;
    my ($userId, $passwd) = @_;
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/users';
    my $request = HTTP::Request->new(GET=>$url);
    $request->header('Accept' => 'application/json');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('PlatformID' => $self->{platformId});
    my $reply = $ua->request($request);
    return $reply->content();
}

sub deleteUser {
    shift;
    my ($userId, $passwd) = @_;
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/users';
    my $request = HTTP::Request->new("DELETE"=>$url);
    $request->header('Accept' => 'application/json');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('PlatformID' => $self->{platformId});
    my $reply = $ua->request($request);
    return $reply->content();
}

sub createEnrollment {
    shift;
    my ($userId, $passwd,$pathToEnrollmentWav, $contentLanguage) = @_;
    my $data = get_filedata($pathToEnrollmentWav);
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/enrollments';
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $request = HTTP::Request->new(POST=>$url);
    $request->header('X-Requested-With' => 'JSONHttpRequest');
    $request->header('Content-Type' => 'audio/wav');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('ContentLanguage' => $contentLanguage // "");
    $request->header('PlatformID' => $self->{platformId});
    $request->content($data);
    my $reply = $ua->request($request);
    return $reply->content();

}

sub createEnrollmentByWavURL {
    shift;
    my ($userId, $passwd,$urlToEnrollmentWav,$contentLanguage) = @_;
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/enrollments/bywavurl';
    my $request = HTTP::Request->new(POST=>$url);
    $request->header('X-Requested-With' => 'JSONHttpRequest');
    $request->header('Content-Type' => 'audio/wav');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('ContentLanguage' => $contentLanguage // "");
    $request->header('PlatformID' => $self->{platformId});
    $request->header('VsitwavURL'=>$urlToEnrollmentWav);
    my $reply = $ua->request($request);
    return $reply->content();
}

sub deleteEnrollment {
    shift;
    my ($userId, $passwd, $enrollmentId) = @_;
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/enrollments'.'/'.$enrollmentId;
    my $request = HTTP::Request->new("DELETE"=>$url);
    $request->header('Accept' => 'application/json');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('PlatformID' => $self->{platformId});
    my $reply = $ua->request($request);
    return $reply->content();
}

sub getEnrollments {
    shift;
    my ($userId, $passwd) = @_;
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/enrollments';
    my $request = HTTP::Request->new(GET=>$url);
    $request->header('Accept' => 'application/json');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('PlatformID' => $self->{platformId});
    my $reply = $ua->request($request);
    return $reply->content();
}

sub authentication {
    shift;
    my ($userId, $passwd, $pathToAuthenticationWav,$contentLanguage) = @_;
    my $data = get_filedata($pathToAuthenticationWav);
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/authentications';
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $request = HTTP::Request->new(POST=>$url);
    $request->header('X-Requested-With' => 'JSONHttpRequest');
    $request->header('Content-Type' => 'audio/wav');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('ContentLanguage' => $contentLanguage // "");
    $request->header('PlatformID' => $self->{platformId});
    $request->content($data);
    my $reply = $ua->request($request);
    return $reply->content();
}

sub authenticationByWavURL {
    shift;
    my ($userId, $passwd,$urlToAuthenticationWav,$contentLanguage) = @_;
    my $ua = LWP::UserAgent->new(ssl_opts=>{ verify_hostname => 0 });
    my $url = 'https://siv.voiceprintportal.com/sivservice/api/enrollments/bywavurl';
    my $request = HTTP::Request->new(POST=>$url);
    $request->header('X-Requested-With' => 'JSONHttpRequest');
    $request->header('Content-Type' => 'audio/wav');
    $request->header('UserId' => $userId);
    $request->header('VsitPassword' => sha256_hex($passwd));
    $request->header('VsitDeveloperId' => $self->{devID});
    $request->header('ContentLanguage' => $contentLanguage // "");
    $request->header('PlatformID' => $self->{platformId});
    $request->header('VsitwavURL'=>$urlToAuthenticationWav);
    my $reply = $ua->request($request);
    return $reply->content();
}

1;
