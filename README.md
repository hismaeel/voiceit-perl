# VoiceIt API 1.0 Perl wrapper
A Wrapper for using the VoiceIt Rest API 1.0.

## Download
You can download the repository and add its contents to your root project folder by cloning or clicking or here [VoiceIt API 1.0 Perl Library](https://github.com/voiceittech/voiceit-perl/archive/master.zip)

## Usage
Then initialize a VoiceIt Object like this with your own developer id
```perl
require VoiceIt;

my $VoiceIt = VoiceIt->new("1d6361f81f3047ca8b0c0332ac0fb17d");
```
Finally use all other API 1.0 Calls as documented on the [VoiceIt API 1.0 Documentation](https://siv.voiceprintportal.com/apidocs.jsp) page.
