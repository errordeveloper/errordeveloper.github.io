---
draft: true
---

Semver voice note — machine transcript
Source: semver-voice-note.m4a (13:46)
Model: whisper.cpp large-v3, unquantized; English; Metal acceleration.

Reviewed as text and compared across machine passes; not verified by listening.
SemVer and CI spellings were normalized in a few places using context.
See review-notes.txt for unresolved wording. Original machine outputs are retained.

[00:00:00] Ensemble bias. The software industry has a bias for using human-readable versions. They often refer to ensemble semantic versioning. that's a great system for humans I always personally found it a little bit daunting because kind of have this false impression of friendliness but it always

[00:00:47] requires a human to decide what version to use what is the next version number for this set of changes this is a this has a number of challenges first of all you need to be sure it's atomic some folks think and completely wrong that having CI run some program read commit messages parse them and the prefixes like chore feat, fix etc may be

[00:01:33] you know, a sensible solution but that requires locking in CI it means that what it means is that there's no atomic locks in CI go on just tell me of an implementation of atomically lockable CI maybe I'm just too complicated and this is a simpler problem right let's not talk about atomic atomicity fine skip that part next if my version is determined by CI for this given piece of software the problem is that I cannot know what the version will be

[00:02:20] until the build has finished right I cannot know it ahead of time well I can try to predetermine it I can make a good guess but what if some change went in just before mine and my guess is invalidated and now I need to add plus one to patch or plus one to minor or plus one to major hmm well what do I do if I want to automate delivery of the software I cannot know what the version will be I do want to know that because I want to make sure that

[00:03:07] the next change I have to make is ready so once the release is out I can line up another PR ahead of that and have that ready to merge in another repo or in a monorepo scenario I might want to be able to update other files based on my predetermined version number so what can I actually do well I can

[00:03:53] possibly just rely on good faith and make guesses guesstimates of the version number and hope for the best that nobody puts a PR in before mine and invalidate my version and hope for the best that their name typos and all of that get invalidated somehow ok I don't really like that possibly work with it maybe fundamentally I honestly don't believe somewhere as a human friendly as it on the flip side to get

[00:04:46] it this way if you have a lot of repositories a lot of different projects each has its own version number and it's all allocated with summer allocator program of some sort the multiple foundations are they're all different different issues so in any case would you end up with lots of lots of human friendly versions are they still human friendly I have no longer slightest idea of what all these versions actually are what do they actually mean i don't even know where to find the changelog for each of these things

[00:05:34] because there's just different pieces of software called one thing or another that might even repo that is has the same name as that piece of software or may live in another repo along with other software and have nothing to do with it and i'll possibly be guessed from the name There is no direct version changelog attribution. Well, if I were shipping tarballs, maybe I would include the changelog in the tarball, but that's not always the case. If I'm shipping container images, boom, maybe I can include the changelog in the container image. Well, in many ways, I'm really not liking it. I'm really not liking non-determinism

[00:06:27] with this human-friendly shenanigans. I'm just pretending that it's all human-friendly. And that is: What if I just used hashes instead of versions and they were deterministic, right? known ahead of the time of the build nevertheless deterministic based on inputs each prior build or if it can afford to run build

[00:07:16] the build is quick enough it's not too expensive

[00:07:24] if i'm making changes to the software luckily will they run the build at some point i better do

[00:07:35] in that case I should be able to know what the resulting hash is going to be and I should be able to apply that to container images as well as binaries that go into those images Now, if that is what I'm doing, do I still care about SemVer? Or is it just like an additional hint I might want to store along the side of the hash in a comment?

[00:08:21] Or maybe I have a database where I store artifact hash mapping to human-friendly tags for release numbers and have some way of retrieving release numbers so that those release numbers mean something. I can look back at one point into that release and I'll look back at, you know, PRs and commit hashes.

[00:08:59] That would seem like a much better way that is actually human-friendly.

[00:09:12] And if I'm using AI engines, do they care about SemVer?

[00:09:21] Well, do they really need SemVer? They can look up the hash more easily than a human does? I mean, I really, as I already said, I cannot possibly make anything out of a random SemVer or a random piece of software. And I still would have to look up the changelog to be able to tell. That's what that is. And I cannot possibly associate the last number I used for a given piece of software with a new number. And it's still the same number. What if I skipped a whole bunch of numbers?

[00:10:07] whatever may have happened

[00:10:20] And if, for security purposes, I'm required to ship container images to Digest,

[00:10:30] the image version tag vanishes as soon as I start deploying by Digest, because container registry relies on either tags or Digest. It cannot handle both. For the same reason, container runtimes and Kubernetes ignore the tag when Digest is supplied.

[00:10:58] In some systems, the combined tag plus digest notation does get preserved,

[00:11:11] but nevertheless the tag is still ignored.

[00:11:18] Reverse lookup. At runtime, it's rather pointless.

[00:11:30] What if there is a mismatch? Should the runtime generate an error, or should it still deploy the application by digest if the digest was pointed at an existing image?

[00:11:44] Okay, maybe we confront this with a policy system? That. Rejects.

[00:11:54] Images where tag and digest are not matched up.

[00:12:08] and then we add extra machinery to also make sure that tags are immutable

[00:12:18] this does sound a lot of point solutions could instead could we instead look at the problem from the perspective i described earlier where we

[00:12:38] purely

[00:12:41] where we drop the need for somewhere entirely

[00:12:49] inside the build systems and ci and in production deal with

[00:12:58] Digests only, and then, and then, when there is a release of a major component,

[00:13:20] it can optionally attach a semantic version to it. I have a system for humans to look that up.
