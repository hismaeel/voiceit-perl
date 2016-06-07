#VoiceIt Perl wrapper
A Wrapper for using the VoiceIt Rest API.

##Download
You can download the respository and add its contents to your root project folder by cloning or clicking or here [VoiceIt Perl Library](https://github.com/voiceittech/voiceit-perl/archive/master.zip)

##Usage
Then initialize a VoiceIt Object like this with your own developer id
```perl
require VoiceIt;

my $VoiceIt = VoiceIt->new("123456");
```
Finally use all other API Calls as documented on the [VoiceIt API Documentation](https://siv.voiceprintportal.com/getstarted.jsp#apidocs) page.
