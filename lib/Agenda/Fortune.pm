# Toby Thurston -- 30 Oct 2015 
package Agenda::Fortune;

use 5.006;
use strict;
use warnings;
use Config;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = ( 'apothegm', 'dictum' );
our @EXPORT = ( 'fortune' );
our $VERSION = '0.6';

use constant SHORT_BYTES => 160;

my @cookies;
{
    local $/ = "\n%\n";
    while (<DATA>) {
        push @cookies, $_
    }
}

sub apothegm { fortune( 'short', @_ ) }

sub dictum   { fortune( 'long', @_ ) }

sub fortune {

    my $size      = 'normal';
    my $review = 0;

    for ( split ' ', join ' ', @_ ) {
        /^(short|long)$/io && do { $size = $1; next };
    }

    my $ln = sub { $size eq 'normal' ? 1 :
                   $size eq 'short'  ? length($_[0]) <= SHORT_BYTES :
                                       length($_[0]) >= SHORT_BYTES };

    my $adage;
    while (1) {
        $adage = $cookies[rand @cookies];
        $adage =~ s/\%\n$//;
        last if $ln->($adage);
    }

    # print and/or return the adage
    return wantarray ? split /^/, $adage : $adage ;
}

1;

=pod

=head1 NAME

Games::Fortune - Perl extension to replicate a subset of `fortune' function

=head1 SYNOPSIS

  use Games::Fortune;
  @lines = fortune();


  #> perl -MGames::Fortune -e"fortune"

=head1 DESCRIPTION

A perl interface to your fortune files.  You need to have a set of fortune files
installed in the standard place: /usr/share/fortune.  (Or
on Windows in c:\cygwin\usr\share\fortune).

Version 0.01 implements only the `short' and `long' options; the -s and -l switches.
These are not done with switches but with different function names.

Version 0.02 implements a more general keyword approach.  You can call fortune() with
a comma list of strings with one or more blank separated words.


=over 4

=item fortune() gets you a random adage

=item fortune('normal') gets you a random adage of any length

=item fortune('short') gets you a random adage that's less than 161 bytes long

=item fortune('long') gets you a random adage that's more than 159 bytes long

=back

If you export the optional subroutine names you can do:

=over 4

=item C<apothegm()>, as a synonym for C<fortune('short')>

=item C<dictum()>, as a synonym for C<fortune('long')>

=back

You can call C<fortune()> in any context.  If you call it in scalar context, you
get back one long string with embedded "\n" characters.  In a list context you get a
list of one or more lines.  In a void context, the adage is printed to STDOUT.
This lets you do a perl one-liner to get `fortune' function, like this:

    perl -MAgenda::Fortune -e"fortune"


=head2 EXPORT

By default, we export "fortune()".  The following subroutines are also exportable.

    use Agenda::Fortune qw(apothegm dictum);


=head1 HISTORY

=over 8

=item 0.1

Original version; created on 13 Dec 2002

=item 0.2

Revised to add emulation of more switches with keywords.

=item 0.3

Added choose switch to allow user to review choice before proceeding.

=back

=head1 TODO

=head1 BUGS

=head1 AUTHOR

Toby Thurston, toby@cpan.org

=head1 SEE ALSO

L<fortune(6)>

L<Fortune.pm> from CPAN.

The Perl Power Tools version of fortune.

=cut


__DATA__
I just thought of something funny...your mother.
- Cheech Marin
%
In the beginning, I was made.  I didn't ask to be made.  No one consulted
with me or considered my feelings in this matter.  But if it brought some
passing fancy to some lowly humans as they haphazardly pranced their way
through life's mournful jungle, then so be it.
- Marvin the Paranoid Android, From Douglas Adams' Hitchiker's Guide to the
Galaxy Radio Scripts
%
You will be successful in your work.
%
The life of a repo man is always intense.
%
If you're not careful, you're going to catch something.
%
That's the thing about people who think they hate computers.  What they
really hate is lousy programmers.
- Larry Niven and Jerry Pournelle in "Oath of Fealty"
%
Wherever you go...There you are.
- Buckaroo Banzai
%
Life in the state of nature is solitary, poor, nasty, brutish, and short.
- Thomas Hobbes, Leviathan
%
Lack of skill dictates economy of style.
- Joey Ramone
%
No one is fit to be trusted with power. ... No one. ... Any man who has lived
at all knows the follies and wickedness he's capabe of. ... And if he does
know it, he knows also that neither he nor any man ought to be allowed to
decide a single human fate.
- C. P. Snow, The Light and the Dark
%
Successful and fortunate crime is called virtue.
- Seneca
%
When we jumped into Sicily, the units became separated, and I couldn't find
anyone.  Eventually I stumbled across two colonels, a major, three captains,
two lieutenants, and one rifleman, and we secured the bridge.  Never in the
history of war have so few been led by so many.
- General James Gavin
%
The only thing necessary for the triumph of evil is for good men to do nothing.
- Edmund Burke
%
You may call me by my name, Wirth, or by my value, Worth.
- Nicklaus Wirth
%
Give a man a fish, and you feed him for a day.
Teach a man to fish, and he'll invite himself over for dinner.
- Calvin Keegan
%
Prediction is very difficult, especially of the future.
- Niels Bohr
%
The computer can't tell you the emotional story.  It can give you the exact
mathematical design, but what's missing is the eyebrows.
- Frank Zappa
%
Things are not as simple as they seems at first.
- Edward Thorp
%
The main thing is the play itself.  I swear that greed for money has nothing
to do with it, although heaven knows I am sorely in need of money.
- Feodor Dostoyevsky
%
It is surely a great calamity for a human being to have no obsessions.
- Robert Bly
%
Machines take me by surprise with great frequency.
- Alan Turing
%
Uncertain fortune is thoroughly mastered by the equity of the calculation.
- Blaise Pascal
%
After Goliath's defeat, giants ceased to command respect.
- Freeman Dyson
%
There are two ways of constructing a software design.  One way is to make
it so simple that there are obviously no deficiencies and the other is to
make it so complicated that there are no obvious deficiencies.
- Charles Anthony Richard Hoare
%
Do not allow this language (Ada) in its present state to be used in
applications where reliability is critical, i.e., nuclear power stations,
cruise missiles, early warning systems, anti-ballistic missle defense
systems.  The next rocket to go astray as a result of a programming language
error may not be an exploratory space rocket on a harmless trip to Venus:
It may be a nuclear warhead exploding over one of our cities.  An unreliable
programming language generating unreliable programs constitutes a far
greater risk to our environment and to our society than unsafe cars, toxic
pesticides, or accidents at nuclear power stations.
- C. A. R. Hoare
%
Without coffee he could not work, or at least he could not have worked in the
way he did.  In addition to paper and pens, he took with him everywhere as an
indispensable article of equipment the coffee machine, which was no less
important to him than his table or his white robe.
- Stefan Zweigs, Biography of Balzac
%
"It was the Law of the Sea, they said. Civilization ends at the waterline.
Beyond that, we all enter the food chain, and not always right at the top."
- Hunter S. Thompson
%
In the pitiful, multipage, connection-boxed form to which the flowchart has
today been elaborated, it has proved to be useless as a design tool --
programmers draw flowcharts after, not before, writing the programs they
describe.
- Fred Brooks, Jr.
%
The so-called "desktop metaphor" of today's workstations is instead an
"airplane-seat" metaphor.  Anyone who has shuffled a lap full of papers while
seated between two portly passengers will recognize the difference -- one can
see only a very few things at once.
- Fred Brooks, Jr.
%
...when fits of creativity run strong, more than one programmer or writer has
been known to abandon the desktop for the more spacious floor.
- Fred Brooks, Jr.
%
A little retrospection shows that although many fine, useful software systems
have been designed by committees and built as part of multipart projects,
those software systems that have excited passionate fans are those that are
the products of one or a few designing minds, great designers.  Consider Unix,
APL, Pascal, Modula, the Smalltalk interface, even Fortran; and contrast them
with Cobol, PL/I, Algol, MVS/370, and MS-DOS.
- Fred Brooks, Jr.
%
...computer hardware progress is so fast.  No other technology since
civilization began has seen six orders of magnitude in performance-price
gain in 30 years.
- Fred Brooks, Jr.
%
Software entities are more complex for their size than perhaps any other human
construct because no two parts are alike.  If they are, we make the two
similar parts into a subroutine -- open or closed.  In this respect, software
systems differ profoundly from computers, buildings, or automobiles, where
repeated elements abound.
- Fred Brooks, Jr.
%
Digital computers are themselves more complex than most things people build:
They hyave very large numbers of states.  This makes conceiving, describing,
and testing them hard.  Software systems have orders-of-magnitude more states
than computers do.
- Fred Brooks, Jr.
%
The complexity of software is an essential property, not an accidental one.
Hence, descriptions of a software entity that abstract away its complexity
often abstract away its essence.
- Fred Brooks, Jr.
%
Einstein argued that there must be simplified explanations of nature, because
God is not capricious or arbitrary.  No such faith comforts the software
engineer.
- Fred Brooks, Jr.
%
Except for 75% of the women, everyone in the whole world wants to have sex.
- Ellyn Mustard
%
The connection between the language in which we think/program and the problems
and solutions we can imagine is very close.  For this reason restricting
language features with the intent of eliminating programmer errors is at best
dangerous.
- Bjarne Stroustrup in "The C++ Programming Language"
%
The only way to learn a new programming language is by writing programs in it.
- Brian Kernighan
%
Perfection is acheived only on the point of collapse.
- C. N. Parkinson
%
There you go man,
Keep as cool as you can.
It riles them to believe that you perceive the web they weave.
Keep on being free!
%
Bingo, gas station, hamburger with a side order of airplane noise,
and you'll be Gary, Indiana. - Jessie in the movie "Greaser's Palace"
%
Hoping to goodness is not theologically sound. - Peanuts
%
Police up your spare rounds and frags.  Don't leave nothin' for the dinks.
- Willem Dafoe in "Platoon"
%
"All my life I wanted to be someone; I guess I should have been more specific."
-- Jane Wagner
%
"Any medium powerful enough to extend man's reach is powerful enough to topple
his world.  To get the medium's magic to work for one's aims rather than
against them is to attain literacy."
-- Alan Kay, "Computer Software", Scientific American, September 1984
%
"Computer literacy is a contact with the activity of computing deep enough to
make the computational equivalent of reading and writing fluent and enjoyable.
As in all the arts, a romance with the material must be well under way.  If
we value the lifelong learning of arts and letters as a springboard for
personal and societal growth, should any less effort be spent to make computing
a part of our lives?"
-- Alan Kay, "Computer Software", Scientific American, September 1984
%
"The greatest warriors are the ones who fight for peace."
-- Holly Near
%
"No matter where you go, there you are..."
-- Buckaroo Banzai
%
Trespassers will be shot.  Survivors will be prosecuted.
%
Trespassers will be shot.  Survivors will be SHOT AGAIN!
%
"I'm growing older, but not up."
-- Jimmy Buffett
%
Scientists will study your brain to learn more about your distant cousin, Man.
%
"I hate the itching.  But I don't mind the swelling."
-- new buzz phrase, like "Where's the Beef?" that David Letterman's trying
   to get everyone to start saying
%
Your own mileage may vary.
%
"Oh dear, I think you'll find reality's on the blink again."
-- Marvin The Paranoid Android
%
"Send lawyers, guns and money..."
-- Lyrics from a Warren Zevon song
%
"I go on working for the same reason a hen goes on laying eggs."
- H. L. Mencken
%
"Remember, Information is not knowledge; Knowledge is not Wisdom;
Wisdom is not truth; Truth is not beauty; Beauty is not love;
Love is not music; Music is the best." -- Frank Zappa
%
I can't drive 55.
%
"And they told us, what they wanted...
 Was a sound that could kill some-one, from a distance." -- Kate Bush
%
"In the face of entropy and nothingness, you kind of have to pretend it's not
there if you want to keep writing good code."  -- Karl Lehenbauer
%
Badges?  We don't need no stinking badges.
%
I can't drive 55.
I'm looking forward to not being able to drive 65, either.
%
Thank God a million billion times you live in Texas.
%
"Can you program?"  "Well, I'm literate, if that's what you mean!"
%
No user-servicable parts inside.  Refer to qualified service personnel.
%
At the heart of science is an essential tension between two seemingly
contradictory attitudes -- an openness to new ideas, no matter how bizarre
or counterintuitive they may be, and the most ruthless skeptical scrutiny
of all ideas, old and new.  This is how deep truths are winnowed from deep
nonsense.  Of course, scientists make mistakes in trying to understand the
world, but there is a built-in error-correcting mechanism:  The collective
enterprise of creative thinking and skeptical thinking together keeps the
field on track.
-- Carl Sagan, "The Fine Art of Baloney Detection," Parade, February 1, 1987
%
One of the saddest lessons of history is this:  If we've been bamboozled
long enough, we tend to reject any evidence of the bamboozle.  We're no
longer interested in finding out the truth.  The bamboozle has captured
us.  it is simply too painful to acknowledge -- even to ourselves -- that
we've been so credulous.  (So the old bamboozles tend to persist as the
new bamboozles rise.)
-- Carl Sagan, "The Fine Art of Baloney Detection," Parade, February 1, 1987
%
Regarding astral projection, Woody Allen once wrote, "This is not a bad way
to travel, although there is usually a half-hour wait for luggage."
%
The inability to benefit from feedback appears to be the primary cause of
pseudoscience.  Pseudoscientists retain their beliefs and ignore or distort
contradictory evidence rather than modify or reject a flawed theory.  Because
of their strong biases, they seem to lack the self-correcting mechanisms
scientists must employ in their work.
-- Thomas L. Creed, "The Skeptical Inquirer," Summer 1987
%
Finding the occasional straw of truth awash in a great ocean of confusion and
bamboozle requires intelligence, vigilance, dedication and courage.  But if we
don't practice these tough habits of thought, we cannot hope to solve the truly
serious problems that face us -- and we risk becoming a nation of suckers, up
for grabs by the next charlatan who comes along.
-- Carl Sagan, "The Fine Art of Baloney Detection," Parade, February 1, 1987
%
Do not underestimate the value of print statements for debugging.
%
Do not underestimate the value of print statements for debugging.
Don't have aesthetic convulsions when using them, either.
%
As the system comes up, the component builders will from time to time appear,
bearing hot new versions of their pieces -- faster, smaller, more complete,
or putatively less buggy.  The replacement of a working component by a new
version requires the same systematic testing procedure that adding a new
component does, although it should require less time, for more complete and
efficient test cases will usually be available.
- Frederick Brooks Jr., "The Mythical Man Month"
%
Each team building another component has been using the most recent tested
version of the integrated system as a test bed for debugging its piece.  Their
work will be set back by having that test bed change under them.  Of course it
must.  But the changes need to be quantized.  Then each user has periods of
productive stability, interrupted by bursts of test-bed change.  This seems
to be much less disruptive than a constant rippling and trembling.
- Frederick Brooks Jr., "The Mythical Man Month"
%
Conceptual integrity in turn dictates that the design must proceed from one
mind, or from a very small number of agreeing resonant minds.
- Frederick Brooks Jr., "The Mythical Man Month"
%
It is a very humbling experience to make a multimillion-dollar mistake, but it
is also very memorable.  I vividly recall the night we decided how to organize
the actual writing of external specifications for OS/360.  The manager of
architecture, the manager of control program implementation, and I were
threshing out the plan, schedule, and division of responsibilities.

The architecture manager had 10 good men.  He asserted that they could write
the specifications and do it right.  It would take ten months, three more
than the schedule allowed.

The control program manager had 150 men.  He asserted that they could prepare
the specifications, with the architecture team coordinating; it would be
well-done and practical, and he could do it on schedule.  Futhermore, if
the architecture team did it, his 150 men would sit twiddling their thumbs
for ten months.

To this the architecture manager responded that if I gave the control program
team the responsibility, the result would not in fact be on time, but would
also be three months late, and of much lower quality.  I did, and it was.  He
was right on both counts.  Moreover, the lack of conceptual integrity made
the system far more costly to build and change, and I would estimate that it
added a year to debugging time.
- Frederick Brooks Jr., "The Mythical Man Month"
%
The reason ESP, for example, is not considered a viable topic in contemoprary
psychology is simply that its investigation has not proven fruitful...After
more than 70 years of study, there still does not exist one example of an ESP
phenomenon that is replicable under controlled conditions.  This simple but
basic scientific criterion has not been met despite dozens of studies conducted
over many decades...It is for this reason alone that the topic is now of little
interest to psychology...In short, there is no demonstrated phenomenon that
needs explanation.
-- Keith E. Stanovich, "How to Think Straight About Psychology", pp. 160-161
%
The evolution of the human race will not be accomplished in the ten thousand
years of tame animals, but in the million years of wild animals, because man
is and will always be a wild animal.
-- Charles Galton Darwin
%
Natural selection won't matter soon, not anywhere as much as concious selection.
We will civilize and alter ourselves to suit our ideas of what we can be.
Within one more human lifespan, we will have changed ourselves unrecognizably.
-- Greg Bear
%
"Jesus may love you, but I think you're garbage wrapped in skin."
-- Michael O'Donohugh
%
...though his invention worked superbly -- his theory was a crock of sewage from
beginning to end. -- Vernor Vinge, "The Peace War"
%
"It's like deja vu all over again."   -- Yogi Berra
%
The last thing one knows in constructing a work is what to put first.
-- Blaise Pascal
%
"Where shall I begin, please your Majesty?" he asked.  "Begin at the beginning,"
the King said, gravely, "and go on till you come to the end: then stop."
Alice's Adventures in Wonderland, Lewis Carroll
%
A morsel of genuine history is a thing so rare as to be always valuable.
-- Thomas Jefferson
%
To be awake is to be alive.  -- Henry David Thoreau, in "Walden"
%
A person with one watch knows what time it is; a person with two watches is
never sure.   Proverb
%
You see but you do not observe.
Sir Arthur Conan Doyle, in "The Memoirs of Sherlock Holmes"
%
A quarrel is quickly settled when deserted by one party; there is no battle
unless there be two.  -- Seneca
%
Nothing ever becomes real till it is experienced -- even a proverb is no proverb
to you till your life has illustrated it.  -- John Keats
%
The fancy is indeed no other than a mode of memory emancipated from the order
of space and time.  -- Samuel Taylor Coleridge
%
What we anticipate seldom occurs; what we least expect generally happens.
-- Bengamin Disraeli
%
Nothing in progression can rest on its original plan.  We may as well think of
rocking a grown man in the cradle of an infant.  -- Edmund Burke
%
For every problem there is one solution which is simple, neat, and wrong.
-- H. L. Mencken
%
Don't tell me how hard you work.  Tell me how much you get done.
-- James J. Ling
%
One friend in a lifetime is much; two are many; three are hardly possible.
Friendship needs a certain parallelism of life, a community of thought,
a rivalry of aim.  -- Henry Brook Adams
%
Remember thee
Ay, thou poor ghost while memory holds a seat
In this distracted globe.  Remember thee!
Yea, from the table of my memory
I'll wipe away all trivial fond records,
All saws of books, all forms, all pressures past,
That youth and observation copied there.
Hamlet, I : v : 95   William Shakespeare
%
Obviously, a man's judgement cannot be better than the information on which he
has based it.  Give him the truth and he may still go wrong when he has
the chance to be right, but give him no news or present him only with distorted
and incomplete data, with ignorant, sloppy or biased reporting, with propaganda
and deliberate falsehoods, and you destroy his whole reasoning processes, and
make him something less than a man.
-- Arthur Hays Sulzberger
%
Each honest calling, each walk of life, has its own elite, its own aristocracy
based on excellence of performance.  -- James Bryant Conant
%
You can observe a lot just by watching.  -- Yogi Berra
%
If the presence of electricity can be made visible in any part of a circuit, I
see no reason why intelligence may not be transmitted instantaneously by
electricity.  -- Samuel F. B. Morse
%
"Mr. Watson, come here, I want you."   -- Alexander Graham Bell
%
It's currently a problem of access to gigabits through punybaud.
-- J. C. R. Licklider
%
It is important to note that probably no large operating system using current
design technology can withstand a determined and well-coordinated attack,
and that most such documented penetrations have been remarkably easy.
-- B. Hebbard, "A Penetration Analysis of the Michigan Terminal System",
Operating Systems Review, Vol. 14, No. 1, June 1980, pp. 7-20
%
A right is not what someone gives you; it's what no one can take from you.
-- Ramsey Clark
%
The price one pays for pursuing any profession, or calling, is an intimate
knowledge of its ugly side.  -- James Baldwin
%
Small is beautiful.
%
...the increased productivity fostered by a friendly environment and quality
tools is essential to meet ever increasing demands for software.
-- M. D. McIlroy, E. N. Pinson and B. A. Tague
%
It is not best to swap horses while crossing the river.
-- Abraham Lincoln
%
Mirrors should reflect a little before throwing back images.
-- Jean Cocteau
%
Suppose for a moment that the automobile industry had developed at the same
rate as computers and over the same period:  how much cheaper and more efficient
would the current models be?  If you have not already heard the analogy, the
answer is shattering.  Today you would be able to buy a Rolls-Royce for $2.75,
it would do three million miles to the gallon, and it would deliver enough
power to drive the Queen Elizabeth II.  And if you were interested in
miniaturization, you could place half a dozen of them on a pinhead.
-- Christopher Evans
%
In the future, you're going to get computers as prizes in breakfast cereals.
You'll throw them out because your house will be littered with them.
-- Robert Lucky
%
Get hold of portable property.  -- Charles Dickens, "Great Expectations"
%
Overall, the philosophy is to attack the availability problem from two
complementary directions:  to reduce the number of software errors through
rigorous testing of running systems, and to reduce the effect of the
remaining errors by providing for recovery from them.  An interesting footnote
to this design is that now a system failure can usually be considered to be
the result of two program errors:  the first, in the program that started the
problem; the second, in the recovery routine that could not protect the
system.  -- A. L. Scherr, "Functional Structure of IBM Virtual Storage Operating
Systems, Part II: OS/VS-2 Concepts and Philosophies," IBM Systems Journal,
Vol. 12, No. 4, 1973, pp. 382-400
%
I have sacrificed time, health, and fortune, in the desire to complete these
Calculating Engines.  I have also declined several offers of great personal
advantage to myself.  But, notwithstanding the sacrifice of these advantages
for the purpose of maturing an engine of almost intellectual power, and after
expending from my own private fortune a larger sum than the government of
England has spent on that machine, the execution of which it only commenced,
I have received neither an acknowledgement of my labors, not even the offer
of those honors or rewards which are allowed to fall within the reach of men
who devote themselves to purely scientific investigations...

If the work upon which I have bestowed so much time and thought were a mere
triumph over mechanical difficulties, or simply curious, or if the execution
of such engines were of doubtful practicability or utility, some justification
might be found for the course which has been taken; but I venture to assert
that no mathematician who has a reputation to lose will ever publicly express
an opinion that such a machine would be useless if made, and that no man
distinguished as a civil engineer will venture to declare the construction of
such machinery impracticable...

And at a period when the progress of physical science is obstructed by that
exhausting intellectual and manual labor, indispensable for its advancement,
which it is the object of the Analytical Engine to relieve, I think the
application of machinery in aid of the most complicated and abtruse
calculations can no longer be deemed unworthy of the attention of the country.
In fact, there is no reason why mental as well as bodily labor should not
be economized by the aid of machinery.
- Charles Babbage, Passage from the Life of a Philosopher
%
How many hardware guys does it take to change a light bulb?

"Well the diagnostics say it's fine buddy, so it's a software problem."
%
"Don't try to outweird me, three-eyes.  I get stranger things than you free
with my breakfast cereal."
- Zaphod Beeblebrox in "Hitchiker's Guide to the Galaxy"
%
Uncompensated overtime?  Just Say No.
%
Decaffeinated coffee?  Just Say No.
%
"Show business is just like high school, except you get paid."
- Martin Mull
%
"This isn't brain surgery; it's just television."
- David Letterman
%
"Morality is one thing.  Ratings are everything."
- A Network 23 executive on "Max Headroom"
%
Live free or die.
%
"...if the church put in half the time on covetousness that it does on lust,
 this would be a better world."  - Garrison Keillor, "Lake Wobegon Days"
%
Outside of a dog, a book is man's best friend.  Inside of a dog, it is too
dark to read.
%
"Probably the best operating system in the world is the [operating system]
 made for the PDP-11 by Bell Laboratories." - Ted Nelson, October 1977
%
"All these black people are screwing up my democracy." - Ian Smith
%
Use the Force, Luke.
%
I've got a bad feeling about this.
%
The power to destroy a planet is insignificant when compared to the power of
the Force.
- Darth Vader
%
When I left you, I was but the pupil.  Now, I am the master.
- Darth Vader
%
"Well, well, well!  Well if it isn't fat stinking billy goat Billy Boy in
poison!  How art thou, thou globby bottle of cheap stinking chip oil?  Come
and get one in the yarbles, if ya have any yarble, ya eunuch jelly thou!"
- Alex in "Clockwork Orange"
%
"There was nothing I hated more than to see a filthy old drunkie, a howling
away at the sons of his father and going blurp blurp in between as if it were
a filthy old orchestra in his stinking rotten guts.  I could never stand to
see anyone like that, especially when they were old like this one was."
- Alex in "Clockwork Orange"
%
186,000 Miles per Second.  It's not just a good idea.  IT'S THE LAW.
%
Stupidity, like virtue, is its own reward.
%
Gee, Toto, I don't think we're in Kansas anymore.
%
Children begin by loving their parents.  After a time they judge them.  Rarely,
if ever, do they forgive them.
- Oscar Wilde
%
Single tasking: Just Say No.
%
"Catch a wave and you're sitting on top of the world."
- The Beach Boys
%
"Bond reflected that good Americans were fine people and that most of them
seemed to come from Texas."
- Ian Fleming, "Casino Royale"
%
"I think trash is the most important manifestation of culture we have in my
lifetime."
- Johnny Legend
%
By one count there are some 700 scientists with respectable academic credentials
(out of a total of 480,000 U.S. earth and life scientists) who give credence
to creation-science, the general theory that complex life forms did not evolve
but appeared "abruptly."
- Newsweek, June 29, 1987, pg. 23
%
Even if you can deceive people about a product through misleading statements,
sooner or later the product will speak for itself.
- Hajime Karatsu
%
In order to succeed in any enterprise, one must be persistent and patient.
Even if one has to run some risks, one must be brave and strong enough to
meet and overcome vexing challenges to maintain a successful business in
the long run.  I cannot help saying that Americans lack this necessary
challenging spirit today.
- Hajime Karatsu
%
Memories of you remind me of you.
-- Karl Lehenbauer
%
Life.  Don't talk to me about life.
- Marvin the Paranoid Android
%
On a clear disk you can seek forever.
%
The world is coming to an end--save your buffers!
%
grep me no patterns and I'll tell you no lines.
%
It is your destiny.
- Darth Vader
%
Hokey religions and ancient weapons are no substitute for a good blaster at
your side.
- Han Solo
%
How many QA engineers does it take to screw in a lightbulb?

3: 1 to screw it in and 2 to say "I told you so" when it doesn't work.
%
How many NASA managers does it take to screw in a lightbulb?

"That's a known problem... don't worry about it."
%
To be is to program.
%
To program is to be.
%
I program, therefore I am.
%
People are very flexible and learn to adjust to strange
surroundings -- they can become accustomed to read Lisp and
Fortran programs, for example.
- Leon Sterling and Ehud Shapiro, Art of Prolog, MIT Press
%
"I am your density."
  -- George McFly in "Back to the Future"
%
"So why don't you make like a tree, and get outta here."
  -- Biff in "Back to the Future"
%
"Falling in love makes smoking pot all day look like the ultimate in restraint."
-- Dave Sim, author of Cerebrus.
%
The existence of god implies a violation of causality.
%
"I may kid around about drugs, but really, I take them seriously."
- Doctor Graper
%
Operating-system software is the program that orchestrates all the basic
functions of a computer.
- The Wall Street Journal, Tuesday, September 15, 1987, page 40
%
I pledge allegiance to the flag
of the United States of America
and to the republic for which it stands,
one nation,
indivisible,
with liberty
and justice for all.
- Francis Bellamy, 1892
%
People think my friend George is weird because he wears sideburns...behind his
ears.  I think he's weird because he wears false teeth...with braces on them.
-- Steven Wright
%
My brother sent me a postcard the other day with this big sattelite photo of
the entire earth on it. On the back it said: "Wish you were here".
 -- Steven Wright
%
You can't have everything... where would you put it?
-- Steven Wright
%
I was playing poker the other night... with Tarot cards. I got a full house and
4 people died.
-- Steven Wright
%
You know that feeling when you're leaning back on a stool and it starts to tip
over?  Well, that's how I feel all the time.
-- Steven Wright
%
I came home the other night and tried to open the door with my car keys...and
the building started up.  So I took it out for a drive.  A cop pulled me over
for speeding.  He asked me where I live... "Right here".
-- Steven Wright
%
"Live or die, I'll make a million."
-- Reebus Kneebus, before his jump to the center of the earth, Firesign Theater
%
The typical page layout program is nothing more than an electronic
light table for cutting and pasting documents.
%
There are bugs and then there are bugs.  And then there are bugs.
-- Karl Lehenbauer
%
My computer can beat up your computer.
- Karl Lehenbauer
%
Kill Ugly Processor Architectures
- Karl Lehenbauer
%
Kill Ugly Radio
- Frank Zappa
%
"Just Say No."   - Nancy Reagan

"No."            - Ronald Reagan
%
I believe that part of what propels science is the thirst for wonder.  It's a
very powerful emotion.  All children feel it.  In a first grade classroom
everybody feels it; in a twelfth grade classroom almost nobody feels it, or
at least acknowledges it.  Something happens between first and twelfth grade,
and it's not just puberty.  Not only do the schools and the media not teach
much skepticism, there is also little encouragement of this stirring sense
of wonder.  Science and pseudoscience both arouse that feeling.  Poor
popularizations of science establish an ecological niche for pseudoscience.
- Carl Sagan, The Burden Of Skepticism, The Skeptical Inquirer, Vol. 12, Fall 87
%
If science were explained to the average person in a way that is accessible
and exciting, there would be no room for pseudoscience.  But there is a kind
of Gresham's Law by which in popular culture the bad science drives out the
good.  And for this I think we have to blame, first, the scientific community
ourselves for not doing a better job of popularizing science, and second, the
media, which are in this respect almost uniformly dreadful.  Every newspaper
in America has a daily astrology column.  How many have even a weekly
astronomy column?  And I believe it is also the fault of the educational
system.  We do not teach how to think.  This is a very serious failure that
may even, in a world rigged with 60,000 nuclear weapons, compromise the human
future.
- Carl Sagan, The Burden Of Skepticism, The Skeptical Inquirer, Vol. 12, Fall 87
%
"I maintain there is much more wonder in science than in pseudoscience.  And
in addition, to whatever measure this term has any meaning, science has the
additional virtue, and it is not an inconsiderable one, of being true.
- Carl Sagan, The Burden Of Skepticism, The Skeptical Inquirer, Vol. 12, Fall 87
%
I'm often asked the question, "Do you think there is extraterrestrial intelli-
gence?"  I give the standard arguments -- there are a lot of places out there,
and use the word *billions*, and so on.  And then I say it would be astonishing
to me if there weren't extraterrestrial intelligence, but of course there is as
yet no compelling evidence for it.  And then I'm asked, "Yeah, but what do you
really think?"  I say, "I just told you what I really think."  "Yeah, but
what's your gut feeling?"  But I try not to think with my gut.  Really, it's
okay to reserve judgment until the evidence is in.
- Carl Sagan, The Burden Of Skepticism, The Skeptical Inquirer, Vol. 12, Fall 87
%
Repel them.  Repel them.  Induce them to relinquish the spheroid.
- Indiana University fans' chant for their perennially bad football team
%
If it's working, the diagnostics say it's fine.
If it's not working, the diagnostics say it's fine.
- A proposed addition to rules for realtime programming
%
   It is either through the influence of narcotic potions, of which all
primitive peoples and races speak in hymns, or through the powerful approach
of spring, penetrating with joy all of nature, that those Dionysian stirrings
arise, which in their intensification lead the individual to forget himself
completely. . . .Not only does the bond between man and man come to be forged
once again by the magic of the Dionysian rite, but alienated, hostile, or
subjugated nature again celebrates her reconciliation with her prodigal son,
man.
- Fred Nietzsche, The Birth of Tragedy
%
The characteristic property of hallucinogens, to suspend the boundaries between
the experiencing self and the outer world in an ecstatic, emotional experience,
makes it posible with their help, and after suitable internal and external
perparation...to evoke a mystical experience according to plan, so to speak...
I see the true importance of LSD in the possibility of providing materail aid
to meditation aimed at the mystical experience of a deeper, comprehensive
reality.  Such a use accords entirely with the essence and working character
of LSD as a sacred drug.
- Dr. Albert Hoffman, the discoverer of LSD
%
I share the belief of many of my contemporaries that the spiritual crisis
pervading all spheres of Western industrial society can be remedied only
by a change in our world view.  We shall have to shift from the materialistic,
dualistic belief that people and their environment are separate, toward a
new conciousness of an all-encompassing reality, which embraces the
experiencing ego, a reality in which people feel their oneness with animate
nature and all of creation.
- Dr. Albert Hoffman
%
Deliberate provocation of mystical experience, particularly by LSD and related
hallucinogens, in contrast to spontaneous visionary experiences, entails
dangers that must not be underestimated.  Practitioners must take into
account the peculiar effects of these substances, namely their ability to
influence our consciousness, the innermost essence of our being.  The history
of LSD to date amply demonstrates the catastrophic consequences that can
ensue when its profound effect is misjudged and the substance is mistaken
for a pleasure drug.  Special internal and external advance preperations
are required; with them, an LSD experiment can become a meaningful
experience.
- Dr. Albert Hoffman, the discoverer of LSD
%
I believe that if people would learn to use LSD's vision-inducing capability
more wisely, under suitable conditions, in medical practice and in conjution
with meditation, then in the future this problem child could become a wonder
child.
- Dr. Albert Hoffman, the discoverer of LSD
%
In the realm of scientific observation, luck is granted only to those who are
prepared.
- Louis Pasteur
%
core error - bus dumped
%
If imprinted foil seal under cap is broken or missing when purchased, do not
use.
%
"Come on over here, baby, I want to do a thing with you."
- A Cop, arresting a non-groovy person after the revolution, Firesign Theater
%
"Ahead warp factor 1"
- Captain Kirk
%
   Fiery energy lanced out, but the beams struck an intangible wall between
the Gubru and the rapidly turning Earth ship.

   "Water!" it shrieked as it read the spectral report.  "A barrier of water
vapor!  A civilized race could not have found such a trick in the Library!
A civilized race could not have stooped so low!  A civilized race would not
have..."

   It screamed as the Gubru ship hit a cloud of drifting snowflakes.

- Startide Rising, by David Brin
%
Harrison's Postulate:
 For every action, there is an equal and opposite criticism.
%
Mr. Cole's Axiom:
 The sum of the intelligence on the planet is a constant;
 the population is growing.
%
Felson's Law:
 To steal ideas from one person is plagiarism; to steal from
 many is research.
%
...Another writer again agreed with all my generalities, but said that as an
inveterate skeptic I have closed my mind to the truth.  Most notably I have
ignored the evidence for an Earth that is six thousand years old.  Well, I
haven't ignored it; I considered the purported evidence and *then* rejected it.
There is a difference, and this is a difference, we might say, between
prejudice and postjudice.  Prejudice is making a judgment before you have
looked at the facts.  Postjudice is making a judgment afterwards.  Prejudice
is terrible, in the sense that you commit injustices and you make serious
mistakes.  Postjudice is not terrible.  You can't be perfect of course; you
may make mistakes also.  But it is permissible to make a judgment after you
have examined the evidence.  In some circles it is even encouraged.
- Carl Sagan, The Burden of Skepticism, Skeptical Enquirer, Vol. 12, pg. 46
%
If a person (a) is poorly, (b) receives treatment intended to make him better,
and (c) gets better, then no power of reasoning known to medical science can
convince him that it may not have been the treatment that restored his health.
- Sir Peter Medawar, The Art of the Soluble
%
America has been discovered before, but it has always been hushed up.
- Oscar Wilde
%
Unix:  Some say the learning curve is steep, but you only have to climb it once.
-- Karl Lehenbauer
%
Sometimes, too long is too long.
- Joe Crowe
%
When bad men combine, the good must associate; else they will fall one by one,
an unpitied sacrifice in a contemptible struggle.
- Edmund Burke
%
Behind all the political rhetoric being hurled at us from abroad, we are
bringing home one unassailable fact -- [terrorism is] a crime by any civilized
standard, committed against innocent people, away from the scene of political
conflict, and must be dealt with as a crime. . . .
   [I]n our recognition of the nature of terrorism as a crime lies our best hope
of dealing with it. . . .
   [L]et us use the tools that we have.  Let us invoke the cooperation we have
the right to expect around the world, and with that cooperation let us shrink
the dark and dank areas of sanctuary until these cowardly marauders are held
to answer as criminals in an open and public trial for the crimes they have
committed, and receive the punishment they so richly deserve.
- William H. Webster, Director, Federal Bureau of Investigation, 15 Oct 1985
%
"Of all the tyrannies that affect mankind, tyranny in religion is the worst."
- Thomas Paine
%
"I say we take off; nuke the site from orbit.  It's the only way to be sure."
- Corporal Hicks, in "Aliens"
%
"There is nothing so deadly as not to hold up to people the opportunity to
do great and wonderful things, if we wish to stimulate them in an active way."
- Dr. Harold Urey, Nobel Laureate in chemistry
%
"...proper attention to Earthly needs of the poor, the depressed and the
downtrodden, would naturally evolve from dynamic, articulate, spirited
awareness of the great goals for Man and the society he conspired to erect."
- David Baker, paraphrasing Harold Urey, in "The History of Manned Space Flight"
%
"Athens built the Acropolis.  Corinth was a commercial city, interested in
purely materialistic things.  Today we admire Athens, visit it, preserve the
old temples, yet we hardly ever set foot in Corinth."
- Dr. Harold Urey, Nobel Laureate in chemistry
%
"Largely because it is so tangible and exciting a program and as such will
serve to keep alive the interest and enthusiasm of the whole spectrum of
society...It is justified because...the program can give a sense of shared
adventure and achievement to the society at large."
- Dr. Colin S. Pittendrigh, in "The History of Manned Space Flight"
%
The challenge of space exploration and particularly of landing men on the moon
represents the greatest challenge which has ever faced the human race.  Even
if there were no clear scientific or other arguments for proceeding with this
task, the whole history of our civilization would still impel men toward the
goal.  In fact, the assembly of the scientific and military with these human
arguments creates such an overwhelming case that in can be ignored only by
those who are blind to the teachings of history, or who wish to suspend the
development of civilization at its moment of greatest opportunity and drama.
- Sir Bernard Lovell, 1962, in "The History of Manned Space Flight"
%
The idea of man leaving this earth and flying to another celestial body and
landing there and stepping out and walking over that body has a fascination
and a driving force that can get the country to a level of energy, ambition,
and will that I do not see in any other undertaking.  I think if we are
honest with ourselves, we must admit that we needed that impetus extremely
strongly.  I sincerely believe that the space program, with its manned
landing on the moon, if wisely executed, will become the spearhead for a
broad front of courageous and energetic activities in all the fields of
endeavour of the human mind - activities which could not be carried out
except in a mental climate of ambition and confidence which such a spearhead
can give.
- Dr. Martin Schwarzschild, 1962, in "The History of Manned Space Flight"
%
Human society - man in a group - rises out of its lethargy to new levels of
productivity only under the stimulus of deeply inspiring and commonly
appreciated goals.  A lethargic world serves no cause well; a spirited world
working diligently toward earnestly desired goals provides the means and
the strength toward which many ends can be satisfied...to unparalleled
social accomplishment.
- Dr. Lloyd V. Berkner, in "The History of Manned Space Flight"
%
The vigor of civilized societies is preserved by the widespread sense that high
aims are worth-while.  Vigorous societies harbor a certain extravagance of
objectives, so that men wander beyond the safe provision of personal
gratifications.  All strong interests easily become impersonal, the love of
a good job well done.  There is a sense of harmony about such an accomplishment,
the Peace brought by something worth-while.
- Alfred North Whitehead, 1963, in "The History of Manned Space Flight"
%
I do not believe that this generation of Americans is willing to resign itself
to going to bed each night by the light of a Communist moon...
- Lyndon B. Johnson
%
Life's the same, except for the shoes.
- The Cars
%
Purple hum
Assorted cars
Laser lights, you bring

All to prove
You're on the move
and vanishing
- The Cars
%
Could be you're crossing the fine line
A silly driver kind of...off the wall

You keep it cool when it's t-t-tight
...eyes wide open when you start to fall.
- The Cars
%
Adapt.  Enjoy.  Survive.
%
Were there fewer fools, knaves would starve.
- Anonymous
%
Humanity has the stars in its future, and that future is too important to be
lost under the burden of juvenile folly and ignorant superstition.
- Isaac Asimov
%
And the crowd was stilled.  One elderly man, wondering at the sudden silence,
turned to the Child and asked him to repeat what he had said.  Wide-eyed,
the Child raised his voice and said once again, "Why, the Emperor has no
clothes!  He is naked!"
- "The Emperor's New Clothes"
%
"Those who believe in astrology are living in houses with foundations of
Silly Putty."
-  Dennis Rawlins, astronomer
%
To date, the firm conclusions of Project Blue Book are:
   1. no unidentified flying object reported, investigated and evaluated
      by the Air Force has ever given any indication of threat to our
      national security;
   2. there has been no evidence submitted to or discovered by the Air
      Force that sightings categorized as UNIDENTIFIED represent
      technological developments or principles beyond the range of
      present-day scientific knowledge; and
   3. there has been no evidence indicating that sightings categorized
      as UNIDENTIFIED are extraterrestrial vehicles.
- the summary of Project Blue Book, an Air Force study of UFOs from 1950
  to 1965, as quoted by James Randi in Flim-Flam!
%
Those who believe that they believe in God, but without passion in their
hearts, without anguish in mind, without uncertainty, without doubt,
without an element of despair even in their consolation, believe only
in the God idea, not God Himself.
- Miguel de Unamuno, Spanish philosopher and writer
%
Doubt is a pain too lonely to know that faith is his twin brother.
- Kahlil Gibran
%
Doubt isn't the opposite of faith; it is an element of faith.
- Paul Tillich, German theologian and historian
%
Doubt is not a pleasant condition, but certainty is absurd.
- Voltaire
%
If only God would give me some clear sign!  Like making a large deposit
in my name at a Swiss Bank.
- Woody Allen
%
I cannot affirm God if I fail to affirm man.  Therefore, I affirm both.
Without a belief in human unity I am hungry and incomplete.  Human unity
is the fulfillment of diversity.  It is the harmony of opposites.  It is
a many-stranded texture, with color and depth.
- Norman Cousins
%
To downgrade the human mind is bad theology.
- C. K. Chesterton
%
...difference of opinion is advantageious in religion.  The several sects
perform the office of a common censor morum over each other.  Is uniformity
attainable?  Millions of innocent men, women, and children, since the
introduction of Christianity, have been burnt, tortured, fined, imprisoned;
yet we have not advanced one inch towards uniformity.
- Thomas Jefferson, "Notes on Virginia"
%
Life is a process, not a principle, a mystery to be lived, not a problem to
be solved.
- Gerard Straub, television producer and author (stolen from Frank Herbert??)
%
So we follow our wandering paths, and the very darkness acts as our guide and
our doubts serve to reassure us.
- Jean-Pierre de Caussade, eighteenth-century Jesuit priest
%
Faith may be defined briefly as an illogical belief in the occurence of the
improbable.
- H. L. Mencken
%
And do you not think that each of you women is an Eve?  The judgement of God
upon your sex endures today; and with it invariably endures your position of
criminal at the bar of justice.
- Tertullian, second-century Christian writer, misogynist
%
I judge a religion as being good or bad based on whether its adherents
become better people as a result of practicing it.
- Joe Mullally, computer salesman
%
Imitation is the sincerest form of plagarism.
%
"Unibus timeout fatal trap program lost sorry"
- An error message printed by DEC's RSTS operating system for the PDP-11
%
How many surrealists does it take to screw in a lightbulb?

One to hold the giraffe and one to fill the bathtub with brightly colored
power tools.
%
How many Bavarian Illuminati does it take to screw in a lightbulb?

Three: one to screw it in, and one to confuse the issue.
%
How long does it take a DEC field service engineer to change a lightbulb?

It depends on how many bad ones he brought with him.
%
It does me no injury for my neighbor to say there are twenty gods or no God.
It neither picks my pocket nor breaks my leg.
- Thomas Jefferson
%
I do not believe in the creed professed by the Jewish Church, by the Roman
Church, by the Greek Church, by the Turkish Church, by the Protestant Church,
nor by any Church that I know of.  My own mind is my own Church.
- Thomas Paine
%
God requireth not a uniformity of religion.
- Roger Williams
%
The day will come when the mystical generation of Jesus, by the Supreme Being
as his Father, in the womb of a virgin will be classified with the fable of
the generation of Minerva in the brain of Jupiter.  But we may hope that the
dawn of reason and freedom of thought in these United States will do away with
this artificial scaffolding and restore to us the primitive and genuine
doctrines of this most venerated Reformer of human errors.
- Thomas Jefferson
%
Let us, then, fellow citizens, unite with one heart and one mind.  Let us
restore to social intercourse that harmony and affection without which
liberty and even life itself are but dreary things.  And let us reflect
that having banished from our land that religious intolerance under which
mankind so long bled, we have yet gained little if we counternance a
political intolerance as despotic, as wicked, and capable of a bitter and
bloody persecutions.
- Thomas Jefferson
%
I do not find in orthodox Christianity one redeeming feature.
- Thomas Jefferson
%
The divinity of Jesus is made a convenient cover for absurdity.  Nowhere
in the Gospels do we find a precept for Creeds, Confessions, Oaths,
Doctrines, and whole carloads of other foolish trumpery that we find in
Christianity.
- John Adams
%
The Bible is not my Book and Christianity is not my religion.  I could
never give assent to the long complicated statements of Christian dogma.
- Abraham Lincoln
%
As to Jesus of Nazareth...I think the system of Morals and his Religion,
as he left them to us, the best the World ever saw or is likely to see;
but I apprehend it has received various corrupting Changes, and I have,
with most of the present Dissenters in England, some doubts as to his
divinity.
- Benjamin Franklin
%
I would have promised those terrorists a trip to Disneyland if it would have
gotten the hostages released.  I thank God they were satisfied with the
missiles and we didn't have to go to that extreme.
- Oliver North
%
I believe in an America where the separation of church and state is absolute --
where no Catholic prelate would tell the president (should he be Catholic)
how to act, and no Protestant minister would tell his parishoners for whom
to vote--where no church or church school is granted any public funds or
political preference--and where no man is denied public office merely
because his religion differs from the president who might appoint him or the
people who might elect him.
- from John F. Kennedy's address to the Greater Houston Ministerial Association
  September 12, 1960.
%
The truth is that Christian theology, like every other theology, is not only
opposed to the scientific spirit; it is also opposed to all other attempts
at rational thinking.  Not by accident does Genesis 3 make the father of
knowledge a serpent -- slimy, sneaking and abominable.  Since the earliest
days the church as an organization has thrown itself violently against every
effort to liberate the body and mind of man.  It has been, at all times and
everywhere, the habitual and incorrigible defender of bad governments, bad
laws, bad social theories, bad institutions.  It was, for centuries, an
apologist for slavery, as it was the apologist for the divine right of kings.
- H. L. Mencken
%
The notion that science does not concern itself with first causes -- that it
leaves the field to theology or metaphysics, and confines itself to mere
effects -- this notion has no support in the plain facts.  If it could,
science would explain the origin of life on earth at once--and there is
every reason to believe that it will do so on some not too remote tomorrow.
To argue that gaps in knowledge which will confront the seeker must be filled,
not by patient inquiry, but by intuition or revelation, is simply to give
ignorance a gratuitous and preposterous dignity....
- H. L. Mencken, 1930
%
The evidence of the emotions, save in cases where it has strong objective
support, is really no evidence at all, for every recognizable emotion has
its opposite, and if one points one way then another points the other way.
Thus the familiar argument that there is an instinctive desire for immortality,
and that this desire proves it to be a fact, becomes puerile when it is
recalled that there is also a powerful and widespread fear of annihilation,
and that this fear, on the same principle proves that there is nothing
beyond the grave.  Such childish "proofs" are typically theological, and
they remain theological even when they are adduced by men who like to
flatter themselves by believing that they are scientific gents....
- H. L. Mencken
%
There is, in fact, no reason to believe that any given natural phenomenon,
however marvelous it may seem today, will remain forever inexplicable.
Soon or late the laws governing the production of life itself will be
discovered in the laboratory, and man may set up business as a creator
on his own account.  The thing, indeed, is not only conceivable; it is
even highly probable.
- H. L. Mencken, 1930
%
The best that we can do is to be kindly and helpful toward our friends and
fellow passengers who are clinging to the same speck of dirt while we are
drifting side by side to our common doom.
- Clarence Darrow
%
We're here to give you a computer, not a religion.
- attributed to Bob Pariseau, at the introduction of the Amiga
%
...there can be no public or private virtue unless the foundation of action is
the practice of truth.
- George Jacob Holyoake
%
"If you'll excuse me a minute, I'm going to have a cup of coffee."
- broadcast from Apollo 11's LEM, "Eagle", to Johnson Space Center, Houston
  July 20, 1969, 7:27 P.M.
%
The meek are contesting the will.
%
I'm sick of being trodden on!  The Elder Gods say they can make me a man!
All it costs is my soul!  I'll do it, cuz NOW I'M MAD!!!
- Necronomicomics #1, Jack Herman & Jeff Dee
%
   On Krat's main screen appeared the holo image of a man, and several dolphins.
From the man's shape, Krat could tell it was a female, probably their leader.
   "...stupid creatures unworthy of the name `sophonts.'  Foolish, pre-sentient
upspring of errant masters.  We slip away from all your armed might, laughing
at your clumsiness!  We slip away as we always will, you pathetic creatures.
And now that we have a real head start, you'll never catch us!  What better
proof that the Progenitors favor not you, but us!  What better proof..."
   The taunt went on.  Krat listened, enraged, yet at the same time savoring
the artistry of it.  These men are better than I'd thought.  Their insults
are wordy and overblown, but they have talent.  They deserve honorable, slow
deaths.
- David Brin, Startide Rising
%
"I'm a mean green mother from outer space"
 -- Audrey II, The Little Shop of Horrors
%
Like my parents, I have never been a regular church member or churchgoer.
It doesn't seem plausible to me that there is the kind of God who
watches over human affairs, listens to prayers, and tries to guide
people to follow His precepts -- there is just too much misery and
cruelty for that.  On the other hand, I respect and envy the people
who get inspiration from their religions.
- Benjamin Spock
%
Any sufficiently advanced technology is indistinguishable from a rigged demo.
- Andy Finkel, computer guy
%
Being schizophrenic is better than living alone.
%
NOWPRINT. NOWPRINT. Clemclone, back to the shadows again.
- The Firesign Theater
%
Yes, many primitive people still believe this myth...But in today's technical
vastness of the future, we can guess that surely things were much different.
- The Firesign Theater
%
...this is an awesome sight.  The entire rebel resistance buried under six
million hardbound copies of "The Naked Lunch."
- The Firesign Theater
%
We want to create puppets that pull their own strings.
- Ann Marion
%
I know engineers.  They love to change things.
- Dr. McCoy
%
On our campus the UNIX system has proved to be not only an effective software
tool, but an agent of technical and social change within the University.
- John Lions (University of New South Wales)
%
Those who do not understand Unix are condemned to reinvent it, poorly.
- Henry Spencer, University of Toronto Unix hack
%
"You know why there are so few sophisticated computer terrorists in the United
States?  Because your hackers have so much mobility into the establishment.
Here, there is no such mobility.  If you have the slightest bit of intellectual
integrity you cannot support the government.... That's why the best computer
minds belong to the opposition."
- an anonymous member of the outlawed Polish trade union, Solidarity
%
"Every Solidarity center had piles and piles of paper .... everyone was
eating paper and a policeman was at the door.  Now all you have to do is
bend a disk."
- an anonymous member of the outlawed Polish trade union, Solidarity,
  commenting on the benefits of using computers in support of their movement
%
Clothes make the man.  Naked people have little or no influence on society.
- Mark Twain
%
The sooner all the animals are extinct, the sooner we'll find their money.
- Ed Bluestone
%
He's dead, Jim.
%
New York... when civilization falls apart, remember, we were way ahead of you.
- David Letterman
%
You can do more with a kind word and a gun than with just a kind word.
- Al Capone
%
The fountain code has been tightened slightly so you can no longer dip objects
into a fountain or drink from one while you are floating in mid-air due to
levitation.

Teleporting to hell via a teleportation trap will no longer occur if the
character does not have fire resistance.

- README file from the NetHack game
%
Remember, there's a big difference between kneeling down and bending over.
- Frank Zappa
%
I think that all right-thinking people in this country are sick and
tired of being told that ordinary decent people are fed up in this
country with being sick and tired.  I'm certainly not.  But I'm
sick and tired of being told that I am.
- Monty Python
%
"There is no statute of limitations on stupidity."
-- Randomly produced by a computer program called Markov3.
%
There is a time in the tides of men,
Which, taken at its flood, leads on to success.
On the other hand, don't count on it.
- T. K. Lawson
%
To follow foolish precedents, and wink
With both our eyes, is easier than to think.
- William Cowper
%
It is the quality rather than the quantity that matters.
- Lucius Annaeus Seneca (4 B.C. - A.D. 65)
%
One may be able to quibble about the quality of a single experiment, or
about the veracity of a given experimenter, but, taking all the supportive
experiments together, the weight of evidence is so strong as readily to
merit a wise man's reflection.
- Professor William Tiller, parapsychologist, Standford University,
  commenting on psi research
%
Nothing ever becomes real until it is experienced.
- John Keats
%
Your good nature will bring you unbounded happiness.
%
"Our journey toward the stars has progressed swiftly.

In 1926 Robert H. Goddard launched the first liquid-propelled rocket,
achieving an altitude of 41 feet.  In 1962 John Glenn orbited the earth.

In 1969, only 66 years after Orville Wright flew two feet off the ground
for 12 seconds, Neil Armstrong, Buzz Aldrin and I rocketed to the moon
in Apollo 11."
-- Michael Collins
   Former astronaut and past Director of the National Air and Space Museum
%
Most people exhibit what political scientists call "the conservatism of the
peasantry."  Don't lose what you've got.  Don't change.  Don't take a chance,
because you might end up starving to death.  Play it safe.  Buy just as much
as you need.  Don't waste time.

When  we think about risk, human beings and corporations realize in their
heads that risks are necessary to grow, to survive.  But when it comes down
to keeping good people when the crunch comes, or investing money in
something untried, only the brave reach deep into their pockets and play
the game as it must be played.

- David Lammers, "Yakitori", Electronic Engineering Times, January 18, 1988
%
"We can't schedule an orgy, it might be construed as fighting"
--Stanley Sutton
%
Weekends were made for programming.
- Karl Lehenbauer
%
"Once he had one leg in the White House and the nation trembled under his
roars.  Now he is a tinpot pope in the Coca-Cola belt and a brother to the
forlorn pastors who belabor halfwits in galvanized iron tabernacles behind
the railroad yards."
- H. L. Mencken, writing of William Jennings Bryan, counsel for the supporters
  of Tennessee's anti-evolution law at the Scopes "Monkey Trial" in 1925.
%
...we must counterpose the overwhelming judgment provided by consistent
observations and inferences by the thousands.  The earth is billions of
years old and its living creatures are linked by ties of evolutionary
descent.  Scientists stand accused of promoting dogma by so stating, but
do we brand people illiberal when they proclaim that the earth is neither
flat nor at the center of the universe?  Science *has* taught us some
things with confidence!  Evolution on an ancient earth is as well
established as our planet's shape and position.  Our continuing struggle
to understand how evolution happens (the "theory of evolution") does not
cast our documentation of its occurrence -- the "fact of evolution" --
into doubt.
- Stephen Jay Gould, "The Verdict on Creationism", The Skeptical Inquirer,
  Vol XII No. 2
%
This was the ultimate form of ostentation among technology freaks -- to have
a system so complete and sophisticated that nothing showed; no machines,
no wires, no controls.
- Michael Swanwick, "Vacuum Flowers"
%
Men ought to know that from the brain and from the brain only arise our
pleasures, joys, laughter, and jests as well as our sorrows, pains, griefs
and tears.  ... It is the same thing which makes us mad or delirious, inspires
us with dread and fear, whether by night or by day, brings us sleeplessness,
inopportune mistakes, aimless anxieties, absent-mindedness and acts that are
contrary to habit...
- Hippocrates (c. 460-c. 377 B.C.), The Sacred Disease
%
Modern psychology takes completely for granted that behavior and neural function
are perfectly correlated, that one is completely caused by the other.  There is
no separate soul or lifeforce to stick a finger into the brain now and then and
make neural cells do what they would not otherwise.  Actually, of course, this
is a working assumption only....It is quite conceivable that someday the
assumption will have to be rejected.  But it is important also to see that we
have not reached that day yet: the working assumption is a necessary one and
there is no real evidence opposed to it.  Our failure to solve a problem so
far does not make it insoluble.  One cannot logically be a determinist in
physics and biology, and a mystic in psychology.
- D. O. Hebb, Organization of Behavior:  A Neuropsychological Theory, 1949
%
Prevalent beliefs that knowledge can be tapped from previous incarnations or
from a "universal mind" (the repository of all past wisdom and creativity)
not only are implausible but also unfairly demean the stunning achievements
of individual human brains.
- Barry L. Beyerstein, "The Brain and Consciousness: Implications for Psi
  Phenomena", The Skeptical Inquirer, Vol. XII No. 2, ppg. 163-171
%
... Fortunately, the responsibility for providing evidence is on the part of
the person making the claim, not the critic.  It is not the responsibility
of UFO skeptics to prove that a UFO has never existed, nor is it the
responsibility of paranormal-health-claims skeptics to prove that crystals
or colored lights never healed anyone.  The skeptic's role is to point out
claims that are not adequately supported by acceptable evidcence and to
provide plausible alternative explanations that are more in keeping with
the accepted body of scientific evidence. ...
- Thomas L. Creed, The Skeptical Inquirer, Vol. XII No. 2, pg. 215
%
"Ada is the work of an architect, not a computer scientist."
- Jean Icbiah, inventor of Ada, weenie
%
Extraordinary claims demand extraordinary proof.  There are many examples of
outsiders who eventually overthrew entrenched scientific orthodoxies, but
they prevailed with irrefutable data.  More often, egregious findings that
contradict well-established research turn out to be artifacts.  I have
argued that accepting psychic powers, reincarnation, "cosmic conciousness,"
and the like, would entail fundamental revisions of the foundations of
neuroscience.  Before abandoning materialist theories of mind that have paid
handsome dividends, we should insist on better evidence for psi phenomena
than presently exists, especially when neurology and psychology themselves
offer more plausible alternatives.
- Barry L. Beyerstein, "The Brain and Conciousness: Implications for Psi
   Phenomena", The Skeptical Inquirer, Vol. XII No. 2, ppg. 163-171
%
Evolution is a bankrupt speculative philosophy, not a scientific fact.
Only a spiritually bankrupt society could ever believe it. ... Only
atheists could accept this Satanic theory.
- Rev. Jimmy Swaggart, "The Pre-Adamic Creation and Evolution"
%
Evolution is as much a fact as the earth turning on its axis and going around
the sun.  At one time this was called the Copernican theory; but, when
evidence for a theory becomes so overwhelming that no informed person
can doubt it, it is customary for scientists to call it a fact.  That all
present life descended from earlier forms, over vast stretches of geologic
time, is as firmly established as Copernican cosmology.  Biologists differ
only with respect to theories about how the process operates.
- Martin Gardner, "Irving Kristol and the Facts of Life",
   The Skeptical Inquirer, Vol. XII No. 2, ppg. 128-131
%
...It is sad to find him belaboring the science community for its united
opposition to ignorant creationists who want teachers and textbooks to
give equal time to crank arguments that have advanced not a step beyond
the flyblown rhetoric of Bishop Wilberforce and William Jennings Bryan.
- Martin Gardner, "Irving Kristol and the Facts of Life",
   The Skeptical Inquirer, Vol. XII No. 2, ppg. 128-131
%
... The book is worth attention for only two reasons:  (1) it attacks
attempts to expose sham paranormal studies; and (2) it is very well and
plausibly written and so rather harder to dismiss or refute by simple
jeering.
- Harry Eagar, reviewing "Beyond the Quantum" by Michael Talbot,
   The Skeptical Inquirer, Vol. XII No. 2, ppg. 200-201
%
Now I lay me down to sleep
I hear the sirens in the street
All my dreams are made of chrome
I have no way to get back home
- Tom Waits
%
I am here by the will of the people and I won't leave until I get my raincoat
back.
- a slogan of the anarchists in Richard Kadrey's "Metrophage"
%
How many nuclear engineers does it take to change a light bulb ?

Seven:  One to install the new bulb, and six to determine what to do
        with the old one for the next 10,000 years.
%
Mike's Law:
For a lumber company employing two men and a cut-off saw, the
marginal product of labor for any number of additional workers
equals zero until the acquisition of another cut-off saw.
Let's not even consider a chainsaw.
- Mike Dennison
[You could always schedule the saw, though - ed.]
%
As long as we're going to reinvent the wheel again, we might as well try making
it round this time.
- Mike Dennison
%
This conjunction of an immense military establishment and a large arms
industry is now in the American experience... We must not fail to
comprehend its grave implications... We must guard against the
acquisition of unwarranted influence...by the military-industrial
complex.  The potential for the disastrous rise of misplaced power
exists and will persist.
- Dwight D. Eisenhower, from his farewell address in 1961
%
This restaurant was advertising breakfast any time. So I ordered
french toast in the renaissance.
- Steven Wright, comedian
%
Everyone has a purpose in life.  Perhaps yours is watching television.
- David Letterman
%
A lot of the stuff I do is so minimal, and it's designed to be minimal.
The smallness of it is what's attractive.  It's weird, 'cause it's so
intellectually lame.  It's hard to see me doing that for the rest of
my life.  But at the same time, it's what I do best.
- Chris Elliot, writer and performer on "Late Night with David Letterman"
%
e-credibility: the non-guaranteeable likelihood that the electronic data
you're seeing is genuine rather than somebody's made-up crap.
- Karl Lehenbauer
%
Whenever people agree with me, I always think I must be wrong.
- Oscar Wilde
%
My mother is a fish.
- William Faulkner
%
The further the spiritual evolution of mankind advances, the more certain it
seems to me that the path to genuine religiosity does not lie through the
fear of life, and the fear of death, and blind faith, but through striving
after rational knowledge.
- Albert Einstein
%
The more a man is imbued with the ordered regularity of all events, the firmer
becomes his conviction that there is no room left by the side of this ordered
regularity for causes of a different nature.  For him neither the rule of
human nor the rule of divine will exists as an independent cause of natural
events.  To be sure, the doctrine of a personal God interfering with natural
events could never be refuted, in the real sense, by science, for this
doctrine can always take refuge in those domains in which scientific knowledge
has not yet been able to set foot.

But I am persuaded that such behavior on the part of the representatives
of religion would not only be unworthy but also fatal.  For a doctrine which
is able to maintain itself not in clear light, but only in the dark, will
of necessity lose its effect on mankind, with incalculable harm to human
progress.  In their struggle for the ethical good, teachers of religion
must have the stature to give up the doctrine of a personal God, that is,
give up that source of fear and hope which in the past placed such vast
powers in the hands of priests.  In their labors they will have to avail
themselves of those forces which are capable of cultivating the Good, the
True, and the Beautiful in humanity itself.  This is, to be sure, a more
difficult but an incomparably more worthy task.
- Albert Einstein
%
Anyone who knows history, particularly the history of Europe, will, I think,
recognize that the domination of education or of government by any one
particular religious faith is never a happy arrangement for the people.
- Eleanor Roosevelt
%
Most non-Catholics know that the Catholic schools are rendering a greater
service to our nation than the public schools in which subversive textbooks
have been used, in which Communist-minded teachers have taught, and from
whose classrooms Christ and even God Himself are barred.
- from "Our Sunday Visitor", an American-Catholic newspaper, 1949
%
Those of us who believe in the right of any human being to belong to whatever
church he sees fit, and to worship God in his own way, cannot be accused
of prejudice when we do not want to see public education connected with
religious control of the schools, which are paid for by taxpayers' money.
- Eleanor Roosevelt
%
Spiritual leadership should remain spiritual leadership and the temporal
power should not become too important in any church.
- Eleanor Roosevelt
%
Truth has always been found to promote the best interests of mankind...
- Percy Bysshe Shelley
%
If atheism is to be used to express the state of mind in which God is
identified with the unknowable, and theology is pronounced to be a
collection of meaningless words about unintelligible chimeras, then
I have no doubt, and I think few people doubt, that atheists are as
plentiful as blackberries...
- Leslie Stephen (1832-1904), literary essayist, author
%
It is wrong always, everywhere and for everyone to believe anything upon
insufficient evidence.
- W. K. Clifford, British philosopher, circa 1876
%
Why, when no honest man will deny in private that every ultimate problem is
wrapped in the profoundest mystery, do honest men proclaim in pulpits
that unhesitating certainty is the duty of the most foolish and ignorant?
Is it not a spectacle to make the angels laugh?  We are a company of
ignorant beings, feeling our way through mists and darkness, learning only
be incessantly repeated blunders, obtaining a glimmering of truth by
falling into every conceivable error, dimly discerning light enough for
our daily needs, but hopelessly differing whenever we attempt to describe
the ultimate origin or end of our paths; and yet, when one of us ventures
to declare that we don't know the map of the universe as well as the map
of our infintesimal parish, he is hooted, reviled, and perhaps told that
he will be damned to all eternity for his faithlessness...
- Leslie Stephen, "An agnostic's Apology", Fortnightly Review, 1876
%
Till then we shall be content to admit openly, what you (religionists)
whisper under your breath or hide in technical jargon, that the ancient
secret is a secret still; that man knows nothing of the Infinite and
Absolute; and that, knowing nothing, he had better not be dogmatic about
his ignorance.  And, meanwhile, we will endeavour to be as charitable as
possible, and whilst you trumpet forth officially your contempt for our
skepticism, we will at least try to believe that you are imposed upon
by your own bluster.
- Leslie Stephen, "An agnostic's Apology", Fortnightly Review, 1876
%
Marriage is the only adventure open to the cowardly.
- Voltaire
%
What is tolerance? -- it is the consequence of humanity.  We are all formed
of frailty and error; let us pardon reciprocally each other's folly --
that is the first law of nature.
- Voltaire
%
It is clear that the individual who persecutes a man, his brother, because
he is not of the same opinion, is a monster.
- Voltaire
%
I simply try to aid in letting the light of historical truth into that
decaying mass of outworn thought which attaches the modern world to
medieval conceptions of Christianity, and which still lingers among us --
a most serious barrier to religion and morals, and a menace to the whole
normal evolution of society.
- Andrew D. White, author, first president of Cornell University, 1896
%
The man scarce lives who is not more credulous than he ought to be.... The
natural disposition is always to believe.  It is acquired wisdom and experience
only that teach incredulity, and they very seldom teach it enough.
- Adam Smith
%
I put the shotgun in an Adidas bag and padded it out with four pairs of tennis
socks, not my style at all, but that was what I was aiming for:  If they think
you're crude, go technical; if they think you're technical, go crude.  I'm a
very technical boy.  So I decided to get as crude as possible.  These days,
though, you have to be pretty technical before you can even aspire to
crudeness.
- Johnny Mnemonic, by William Gibson
%
However, on religious issures there can be little or no compromise.
There is no position on which people are so immovable as their religious
beliefs.  There is no more powerful ally one can claim in a debate than
Jesus Christ, or God, or Allah, or whatever one calls this supreme being.
But like any powerful weapon, the use of God's name on one's behalf
should be used sparingly.  The religious factions that are growing
throughout our land are not using their religious clout with wisdom.
They are trying to force government leaders into following their position
100 percent.  If you disagree with these religious groups on a
particular moral issue, they complain, they threaten you with a loss of
money or votes or both.  I'm frankly sick and tired of the political
preachers across this country telling me as a citizen that if I want to be
a moral person, I must believe in "A," "B," "C," and "D."  Just who do
they think they are?  And from where do they presume to claim the
right to dictate their moral beliefs to me?  And I am even more angry as
a legislator who must endure the threats of every religious group who
thinks it has some God-granted right to control my vote on every roll
call in the Senate.  I am warning them today:  I will fight them every
step of the way if they try to dictate their moral convictions to all
Americans in the name of "conservatism."
- Senator Barry Goldwater, from the Congressional Record, September 16, 1981
%
"I think every good Christian ought to kick Falwell's ass."
- Senator Barry Goldwater, when asked what he thought of Jerry Falwell's
suggestion that all good Christians should be against Sandra Day O'Connor's
nomination to the Supreme Court
%
...And no philosophy, sadly, has all the answers.  No matter how assured
we may be about certain aspects of our belief, there are always painful
inconsistencies, exceptions, and contradictions.  This is true in religion as
it is in politics, and is self-evident to all except fanatics and the naive.
As for the fanatics, whose number is legion in our own time, we might be
advised to leave them to heaven.  They will not, unfortunately, do us the
same courtesy.  They attack us and each other, and whatever their
protestations to peaceful intent, the bloody record of history makes clear
that they are easily disposed to restore to the sword.  My own belief in
God, then, is just that -- a matter of belief, not knowledge.  My respect
for Jesus Christ arises from the fact that He seems to have been the
most virtuous inhabitant of Planet Earth.  But even well-educated Christians
are frustated in their thirst for certainty about the beloved figure
of Jesus because of the undeniable ambiguity of the scriptural record.
Such ambiguity is not apparent to children or fanatics, but every
recognized Bible scholar is perfectly aware of it.  Some Christians, alas,
resort to formal lying to obscure such reality.
- Steve Allen, comdeian, from an essay in the book "The Courage of
  Conviction", edited by Philip Berman
%
...it still remains true that as a set of cognitive beliefs about the
existence of God in any recognizable sense continuous with the great
systems of the past, religious doctrines constitute a speculative
hypothesis of an extremely low order of probability.
- Sidney Hook
%
A fanatic is a person who can't change his mind and won't change the subject.
- Winston Churchill
%
We're fighting against humanism, we're fighting against liberalism...
we are fighting against all the systems of Satan that are destroying
our nation today...our battle is with Satan himself.
- Jerry Falwell
%
They [preachers] dread the advance of science as witches do the approach
of daylight and scowl on the fatal harbinger announcing the subversions
of the duperies on which they live.
- Thomas Jefferson
%
Saints should always be judged guilty until they are proven innocent.
- George Orwell
%
As I argued in "Beloved Son", a book about my son Brian and the subject
of religious communes and cults, one result of proper early instruction
in the methods of rational thought will be to make sudden mindless
conversions -- to anything -- less likely.  Brian now realizes this and
has, after eleven years, left the sect he was associated with.  The
problem is that once the untrained mind has made a formal commitment to
a religious philosophy -- and it does not matter whether that philosophy
is generally reasonable and high-minded or utterly bizarre and
irrational -- the powers of reason are suprisingly ineffective in
changing the believer's mind.
- Steve Allen, comdeian, from an essay in the book "The Courage of
  Conviction", edited by Philip Berman
%
Nothing is easier than to denounce the evildoer; nothing is more difficult
than to understand him.
- Fyodor Dostoevski
%
We may not be able to persuade Hindus that Jesus and not Vishnu should
govern their spiritual horizon, nor Moslems that Lord Buddha is at the
center of their spiritual universe, nor Hebrews that Mohammed is a major
prohpet, nor Christians that Shinto best expresses their spiritual
concerns, to say nothing of the fact that we may not be able to get
Christians to agree among themselves about their relationship to God.
But all will agree on a proposition that they possess profound spiritual
resources.  If, in addition, we can get them to accept the further
proposition that whatever form the Deity may have in their own theology,
the Deity is not only external, but internal and acts through them, and
they themselves give proof or disproof of the Deity in what they do and
think; if this further proposition can be accepted, then we come that
much closer to a truly religious situation on earth.
- Norman Cousins, from his book "Human Options"
%
The Messiah will come.  There will be a resurrection of the dead -- all
the things that Jews believed in before they got so damn sophisticated.
- Rabbi Meir Kahane
%
The world is no nursery.
- Sigmund Freud
%
If one inquires why the American tradition is so strong against any
connection of State and Church, why it dreads even the rudiments of
religious teaching in state-maintained schools, the immediate and
superficial answer is not far to seek....
The cause lay largely in the diversity and vitality of the various
denominations, each fairly sure that, with a fair field and no favor,
it could make its own way; and each animated by a jealous fear that,
if any connection of State and Church were permitted, some rival
denomination would get an unfair advantage.
- John Dewey (1859-1953), American philosopher,
  from "Democracy in the Schools", 1908
%
Already the spirit of our schooling is permeated with the feeling that
every subject, every topic, every fact, every professed truth must be
submitted to a certain publicity and impartiality.  All proffered
samples of learning must go to the same assay-room and be subjected to
common tests.  It is the essence of all dogmatic faiths to hold that
any such "show-down" is sacrilegious and perverse.  The characteristic
of religion, from their point of view, is that it is intellectually
secret, not public; peculiarly revealed, not generall known;
authoritatively declared, not communicated and tested in ordinary
ways...It is pertinent to point out that, as long as religion is
conceived as it is now by the great majority of professed religionists,
there is something self-contradictory in speaking of education in
religion in the same sense in which we speak of education in topics
where the method of free inquiry has made its way.  The "religious"
would be the last to be willing that either the history of the
content of religion should be taught in this spirit; while those
to whom the scientific standpoint is not merely a technical device,
but is the embodiment of the integrity of mind, must protest against
its being taught in any other spirit.
- John Dewey (1859-1953), American philosopher,
  from "Democracy in the Schools", 1908
%
In the broad and final sense all institutions are educational in the
sense that they operate to form the attitudes, dispositions, abilities
and disabilities that constitute a concrete personality...Whether this
educative process is carried on in a predominantly democratic or non-
democratic way becomes, therefore, a question of transcendent importance
not only for education itself but for its final effect upon all the
interests and activites of a society that is committed to the democratic
way of life.
- John Dewey (1859-1953), American philosopher
%
History shows that the human mind, fed by constant accessions of knowledge,
periodically grows too large for its theoretical coverings, and bursts
them asunder to appear in new habiliments, as the feeding and growing
grub, at intervals, casts its too narrow skin and assumes another...
Truly the imago state of Man seems to be terribly distant, but every
moult is a step gained.
- Charles Darwin, from "Origin of the Species"
%
...I would go so far as to suggest that, were it not for our ego and
concern to be different, the African apes would be included in our
family, the Hominidae.
- Richard Leakey
%
It is inconceivable that a judicious observer from another solar system
would see in our species -- which has tended to be cruel, destructive,
wasteful, and irrational -- the crown and apex of cosmic evolution.
Viewing us as the culmination of *anything* is grotesque; viewing us
as a transitional species makes more sense -- and gives us more hope.
- Betty McCollister, "Our Transitional Species",
  Free Inquiry magazine, Vol. 8, No. 1
%
"Well, you see, it's such a transitional creature.  It's a piss-poor
reptile and not very much of a bird."
- Melvin Konner, from "The Tangled Wing", quoting a zoologist who has
studied the archeopteryz and found it "very much like people"
%
"You need tender loving care once a week - so that I can slap you into shape."
- Ellyn Mustard
%
"It may be that our role on this planet is not to worship God but to
 create him."
 -Arthur C. Clarke
%
"Why should we subsidize intellectual curiosity?"
 -Ronald Reagan
%
"There is nothing new under the sun, but there are lots of old things
 we don't know yet."
 -Ambrose Bierce
%
"Plan to throw one away.  You will anyway."
- Fred Brooks, "The Mythical Man Month"
%
You need tender loving care once a week - so that I can slap you into shape.
- Ellyn Mustard
%
"It may be that our role on this planet is not to worship God but to
 create him."
 -Arthur C. Clarke
%
"Why should we subsidize intellectual curiosity?"
 -Ronald Reagan
%
"There is nothing new under the sun, but there are lots of old things
 we don't know yet."
 -Ambrose Bierce
%
The Middle East is certainly the nexus of turmoil for a long time to come --
with shifting players, but the same game: upheaval.  I think we will be
confronting militant Islam -- particularly fallout from the Iranian
revolution -- and religion will once more, as it has in our own more
distant past -- play a role at least as standard-bearer in death and mayhem.
- Bobby R. Inman, Admiral, USN, Retired, former director of Naval Intelligence,
  vice director of the DIA, former director of the NSA, deputy director of
  Central Intelligence, former chairman and CEO of MCC.
%
...One thing is that, unlike any other Western democracy that I know of,
this country has operated since its beginnings with a basic distrust of
government.  We are constituted not for efficient operation of government,
but for minimizing the possibility of abuse of power.  It took the events
of the Roosevelt era -- a catastrophic economic collapse and a world war --
to introduce the strong central government that we now know.  But in most
parts of the country today, the reluctance to have government is still
strong.  I think, barring a series of catastrophic events, that we can
look to at least another decade during which many of the big problems
around this country will have to be addressed by institutions other than
federal government.
- Bobby R. Inman, Admiral, USN, Retired, former director of Naval Intelligence,
  vice director of the DIA, former director of the NSA, deputy directory of
  Central Intelligence, former chairman and CEO of MCC.
[the statist opinions expressed herein are not those of the cookie editor -ed.]
%
"I have just one word for you, my boy...plastics."
- from "The Graduate"
%
"There is such a fine line between genius and stupidity."
- David St. Hubbins, "Spinal Tap"
%
"If Diet Coke did not exist it would have been neccessary to invent it."
-- Karl Lehenbauer
%
I am approached with the most opposite opinions and advice, and by men who
are equally certain that they represent the divine will.  I am sure that
either the one or the other is mistaken in the belief, and perhaps in some
respects, both.

I hope it will not be irreverent of me to say that if it is probable that
God would reveal his will to others on a point so connected with my duty,
it might be supposed he would reveal it directly to me.
- Abraham Lincoln
%
In space, no one can hear you fart.
%
Brain damage is all in your head.
-- Karl Lehenbauer
%
Wish and hope succeed in discerning signs of paranormality where reason and
careful scientific procedure fail.
- James E. Alcock, The Skeptical Inquirer, Vol. 12
%
"It is better to have tried and failed than to have failed to try, but
the result's the same."
- Mike Dennison
%
"Creation science" has not entered the curriculum for a reason so simple
and so basic that we often forget to mention it: because it is false, and
because good teachers understand exactly why it is false.  What could be
more destructive of that most fragile yet most precious commodity in our
entire intellectualy heritage -- good teaching -- than a bill forcing
honorable teachers to sully their sacred trust by granting equal treatment
to a doctrine not only known to be false, but calculated to undermine any
general understanding of science as an enterprise?
-- Stephen Jay Gould, "The Skeptical Inquirer", Vol. 12, page 186
%
It is not well to be thought of as one who meekly submits to insolence and
intimidation.
%
"Regardless of the legal speed limit, your Buick must be operated at
speeds faster than 85 MPH (140kph)."
-- 1987 Buick Grand National owners manual.
%
"Your attitude determines your attitude."
-- Zig Ziglar, self-improvement doofus
%
In arguing that current theories of brain function cast suspicion on ESP,
psychokinesis, reincarnation, and so on, I am frequently challenged with
the most popular of all neuro-mythologies -- the notion that we ordinarily
use only 10 percent of our brains...

This "cerebral spare tire" concept continues to nourish the clientele of
"pop psychologists" and their many recycling self-improvement schemes.  As
a metaphor for the fact that few of us fully exploit our talents, who could
deny it?  As a refuge for occultists seeking a neural basis of the miraculous,
it leaves much to be desired.
-- Barry L. Beyerstein, "The Brain and Consciousness:  Implications for
   Psi Phenomena", The Skeptical Enquirer, Vol. XII, No. 2, pg. 171
%
Thufir's a Harkonnen now.
%
"By long-standing tradition, I take this opportunity to savage other
designers in the thin disguise of good, clean fun."
-- P. J. Plauger, from his April Fool's column in April 88's "Computer Language"
%
"If you want to eat hippopatomus, you've got to pay the freight."
-- attributed to an IBM guy, about why IBM software uses so much memory
%
Parkinson's Law:  Work expands to fill the time alloted it.
%
Karl's version of Parkinson's Law:  Work expands to exceed the time alloted it.
%
It is better to never have tried anything than to have tried something and
failed.
- motto of jerks, weenies and losers everywhere
%
"Our journeys to the stars will be made on spaceships created by determined,
hardworking scientists and engineers applying the principles of science, not
aboard flying saucers piloted by little gray aliens from some other dimension."
-- Robert A. Baker, "The Aliens Among Us:  Hypnotic Regression Revisited",
   The Skeptical Inquirer, Vol. XII, No. 2
%
"...all the good computer designs are bootlegged; the formally planned products,
if they are built at all, are dogs!"
-- David E. Lundstrom, "A Few Good Men From Univac", MIT Press, 1987
%
"To take a significant step forward, you must make a series of finite
improvements."
-- Donald J. Atwood, General Motors
%
"We will bury you."
-- Nikita Kruschev
%
"Now here's something you're really going to like!"
-- Rocket J. Squirrel
%
"How to make a million dollars:  First, get a million dollars."
-- Steve Martin
%
"Language shapes the way we think, and determines what we can think about."
-- B. L. Whorf
%
The language provides a programmer with a set of conceptual tools; if these are
inadequate for the task, they will simply be ignored.  For example, seriously
restricting the concept of a pointer simply forces the programmer to use a
vector plus integer arithmetic to implement structures, pointer, etc.  Good
design and the absence of errors cannot be guaranteed by mere language
features.
-- Bjarne Stroustrup, "The C++ Programming Language"
%
"For the love of phlegm...a stupid wall of death rays.  How tacky can ya get?"
- Post Brothers comics
%
"Bureaucracy is the enemy of innovation."
-- Mark Shepherd, former President and CEO of Texas Instruments
%
"An organization dries up if you don't challenge it with growth."
-- Mark Shepherd, former President and CEO of Texas Instruments
%
"I've seen it.  It's rubbish."
-- Marvin the Paranoid Android
%
Our business is run on trust.  We trust you will pay in advance.
%
"Infidels in all ages have battled for the rights of man, and have at all times
been the fearless advocates of liberty and justice."
-- Robert Green Ingersoll
%
The history of the rise of Christianity has everything to do with politics,
culture, and human frailties and nothing to do with supernatural manipulation
of events.  Had divine intervention been the guiding force, surely two
millennia after the birth of Jesus he would not have a world where there
are more Muslims than Catholics, more Hindus than Protestants, and more
nontheists than Catholics and Protestants combined.
-- John K. Naland, "The First Easter", Free Inquiry magazine, Vol. 8, No. 2
%
I find you lack of faith in the forth dithturbing.
- Darse ("Darth") Vader
%
"All Bibles are man-made."
-- Thomas Edison
%
"Spock, did you see the looks on their faces?"
"Yes, Captain, a sort of vacant contentment."
%
"The triumph of libertarian anarchy is nearly (in historical terms) at
hand... *if* we can keep the Left from selling us into slavery and the
Right from blowing us up for, say, the next twenty years."
-- Eric Rayman, usenet guy, about nanotechnology
%
"Gravitation cannot be held responsible for people falling in love."
-- Albert Einstein
%
"I think Michael is like litmus paper - he's always trying to learn."
-- Elizabeth Taylor, absurd non-sequitir about Michael Jackson
%
While it cannot be proved retrospectively that any experience of possession,
conversion, revelation, or divine ecstasy was merely an epileptic discharge,
we must ask how one differentiates "real transcendence" from neuropathies
that produce the same extreme realness, profundity, ineffability, and sense
of cosmic unity.  When accounts of sudden religious conversions in TLEs
[temporal-lobe epileptics] are laid alongside the epiphanous revelations of
the religious tradition, the parallels are striking.  The same is true of the
recent spate of alleged UFO abductees.  Parsimony alone argues against invoking
spirits, demons, or extraterrestrials when natural causes will suffice.
-- Barry L. Beyerstein, "Neuropathology and the Legacy of Spiritual
   Possession", The Skeptical Inquirer, Vol. XII, No. 3, pg. 255
%
"A verbal contract isn't worth the paper it's printed on."
- Samuel Goldwyn
%
"We shall reach greater and greater platitudes of achievement."
-- Richard J. Daley
%
"With molasses you catch flies, with vinegar you catch nobody."
-- Baltimore City Councilman Dominic DiPietro
%
"Lead us in a few words of silent prayer."
-- Bill Peterson, former Houston Oiler football coach
%
"I couldn't remember things until I took that Sam Carnegie course."
-- Bill Peterson, former Houston Oiler football coach
%
"Right now I feel that I've got my feet on the ground as far as my head
is concerned."
-- Baseball pitcher Bo Belinsky
%
"Ninety percent of baseball is half mental."
-- Yogi Berra
%
Two things are certain about science.  It does not stand still for long,
and it is never boring.  Oh, among some poor souls, including even
intellectuals in fields of high scholarship, science is frequently
misperceived.  Many see it as only a body of facts, promulgated from
on high in must, unintelligible textbooks, a collection of unchanging
precepts defended with authoritarian vigor.  Others view it as nothing
but a cold, dry narrow, plodding, rule-bound process -- the scientific
method: hidebound, linear, and left brained.

These people are the victims of their own stereotypes.  They are
destined to view the world of science with a set of blinders.  They
know nothing of the tumult, cacophony, rambunctiousness, and
tendentiousness of the actual scientific process, let alone the
creativity, passion, and joy of discovery.  And they are likely to
know little of the continual procession of new insights and discoveries
that every day, in some way, change our view (if not theirs) of the
natural world.

-- Kendrick Frazier, "The Year in Science: An Overview," in
   1988 Yearbook of Science and the Future, Encyclopaedia Britannica, Inc.
%
"jackpot:  you may have an unneccessary change record"
-- message from "diff"
%
"One lawyer can steal more than a hundred men with guns."
-- The Godfather
%
What's the difference between a computer salesman and a used car salesman?

A used car salesman knows when he's lying.
%
"Those who will be able to conquer software will be able to conquer the
world."
-- Tadahiro Sekimoto, president, NEC Corp.
%
"There are some good people in it, but the orchestra as a whole is equivalent
to a gang bent on destruction."
-- John Cage, composer
%
"I believe the use of noise to make music will increase until we reach a
music produced through the aid of electrical instruments which will make
available for musical purposes any and all sounds that can be heard."
-- composer John Cage, 1937
%
I did cancel one performance in Holland where they thought my music was so easy
that they didn't rehearse at all.  And so the first time when I found that out,
I rehearsed the orchestra myself in front of the audience of 3,000 people and
the next day I rehearsed through the second movement -- this was the piece
_Cheap Imitation_ -- and they then were ashamed.  The Dutch people were ashamed
and they invited me to come to the Holland festival and they promised to
rehearse.  And when I got to Amsterdam they had changed the orchestra, and
again, they hadn't rehearsed.  So they were no more prepared the second time
than they had been the first.  I gave them a lecture and told them to cancel
the performance; they then said over the radio that i had insisted on their
cancelling the performance because they were "insufficiently Zen."
Can you believe it?
-- composer John Cage, "Electronic Musician" magazine, March 88, pg. 89
%
"One day I woke up and discovered that I was in love with tripe."
-- Tom Anderson
%
"Most people would like to be delivered from
 temptation but would like it to keep in touch."
-- Robert Orben
%
The rule on staying alive as a program manager is to give 'em a number or
give 'em a date, but never give 'em both at once.
%
An optimist believes we live in the best world possible;
a pessimist fears this is true.
%
"If John Madden steps outside on February 2, looks down, and doesn't see his
feet, we'll have 6 more weeks of Pro football."
-- Chuck Newcombe
%
Dead? No excuse for laying off work.
%
Lead me not into temptation... I can find it myself.
%
"When people are least sure, they are often most dogmatic."
-- John Kenneth Galbraith
%
"Nature is very un-American.  Nature never hurries."
-- William George Jordan
%
"We learn from history that we learn nothing from history."
-- George Bernard Shaw
%
"Flattery is all right -- if you don't inhale."
-- Adlai Stevenson
%
"Consistency requires you to be as ignorant today as you were a year ago."
-- Bernard Berenson
%
"Summit meetings tend to be like panda matings.  The expectations are always
high, and the results usually disappointing."
-- Robert Orben
%
"A great many people think they are thinking when they are merely rearranging
their prejudices."
-- William James
%
"Tell the truth and run."
-- Yugoslav proverb
%
"The best index to a person's character is a) how he treats people who can't
do him any good and b) how he treats people who can't fight back."
-- Abigail Van Buren
%
"Never face facts; if you do, you'll never get up in the morning."
-- Marlo Thomas
%
"Life is a garment we continuously alter, but which never seems to fit."
-- David McCord
%
"The value of marriage is not that adults produce children, but that children
produce adults."
-- Peter De Vries
%
"It is easier to fight for principles than to live up to them."
-- Alfred Adler
%
"Security is mostly a superstition.  It does not exist in nature... Life is
either a daring adventure or nothing."
-- Helen Keller
%
"Whoever undertakes to set himself up as a judge of Truth and Knowledge is
shipwrecked by the laughter of the gods."
-- Albert Einstein
%
"Success covers a multitude of blunders."
-- George Bernard Shaw
%
"The mark of an immature man is that he wants to die nobly for a cause, while
the mark of a mature man is that he wants to live humbly for one."
-- William Stekel
%
"Yes, and I feel bad about rendering their useless carci into dogfood..."
-- Badger comics
%
"Is it really you, Fuzz, or is it Memorex, or is it radiation sickness?"
-- Sonic Disruptors comics
%
"Most of us, when all is said and done, like what we like and make up reasons
for it afterwards."
-- Soren F. Petersen
%
"You're a creature of the night, Michael.  Wait'll Mom hears about this."
-- from the movie "The Lost Boys"
%
"Plastic gun.  Ingenious.  More coffee, please."
-- The Phantom comics
%
The game of life is a game of boomerangs.  Our thoughts, deeds and words
return to us sooner or later with astounding accuracy.
%
If at first you don't succeed, you are running about average.
%
"A child is a person who can't understand why someone would give away a
perfectly good kitten."
-- Doug Larson
%
"The trouble with doing something right the first time is that nobody
appreciates how difficult it was."
-- Walt West
%
"Silent gratitude isn't very much use to anyone."
-- G. B. Stearn
%
"In matters of principle, stand like a rock; in matters of taste, swim with
the current."
-- Thomas Jefferson
%
The first sign of maturity is the discovery that the volume knob also turns to
the left.
%
"But this one goes to eleven."
-- Nigel Tufnel
%
"Been through Hell?  Whaddya bring back for me?"
-- A. Brilliant
%
"I don't know what their
 gripe is.  A critic is
 simply someone paid to
 render opinions glibly."
        "Critics are grinks and
         groinks."
-- Baron and Badger, from Badger comics
%
"I've got some amyls.  We could either party later or, like, start his heart."
-- "Cheech and Chong's Next Movie"
%
"Israel today announced that it is giving up.  The Zionist state will dissolve
in two weeks time, and its citizens will disperse to various resort communities
around the world.  Said Prime Minister Yitzhak Shamir, 'Who needs the
aggravation?'"
-- Dennis Miller, "Satuday Night Live" News
%
"And, of course, you have the commercials where savvy businesspeople Get Ahead
by using their MacIntosh computers to create the ultimate American business
product: a really sharp-looking report."
-- Dave Barry
%
SHOP OR DIE, people of Earth!
[offer void where prohibited]
-- Capitalists from outer space, from Justice League Int'l comics
%
"Roman Polanski makes his own blood.  He's smart -- that's why his movies work."
-- A brilliant director at "Frank's Place"
%
"The following is not for the weak of heart or Fundamentalists."
-- Dave Barry
%
"I take Him shopping with me. I say, 'OK, Jesus, help me find a bargain'"
--Tammy Faye Bakker
%
Gary Hart:  living proof that you *can* screw your brains out.
%
Blessed be those who initiate lively discussions with the hopelessly mute,
for they shall be know as Dentists.
%
"I don't believe in sweeping social change being manifested by one person,
unless he has an atomic weapon."
-- Howard Chaykin
%
"Ever free-climbed a thousand foot vertical cliff with 60 pounds of gear
strapped to your butt?"
   "No."
"'Course you haven't, you fruit-loop little geek."
-- The Mountain Man, one of Dana Carvey's SNL characters
[ditto]
%
"I mean, like, I just read your article in the Yale law recipe, on search and
seizure.  Man, that was really Out There."
   "I was so WRECKED when I wrote that..."
-- John Lovitz, as ex-Supreme Court nominee Alan Ginsburg, on SNL
%
"Hi, I'm Professor Alan Ginsburg... But you can call me... Captain Toke."
-- John Lovitz, as ex-Supreme Court nominee Alan Ginsburg, on SNL
%
It's great to be smart 'cause then you know stuff.
%
"Time is money and money can't buy you love and I love your outfit"
- T.H.U.N.D.E.R. #1
%
"Can't you just gesture hypnotically and make him disappear?"
    "It does not work that way.  RUN!"
-- Hadji on metaphyics and Mandrake in "Johnny Quest"
%
"You shouldn't make my toaster angry."
-- Household security explained in "Johnny Quest"
%
 "Someone's been mean to you! Tell me who it is, so I can punch him tastefully."
-- Ralph Bakshi's Mighty Mouse
%
"And kids... learn something from Susie and Eddie.
 If you think there's a maniacal psycho-geek in the
 basement:
    1) Don't give him a chance to hit you on the
 head with an axe!
    2) Flee the premises... even if you're in your
 underwear.
    3) Warn the neighbors and call the police.
 But whatever else you do... DON'T GO DOWN IN THE DAMN BASEMENT!"
-- Saturday Night Live meets Friday the 13th
%
Victory or defeat!
%
"Everyone is entitled to an *informed* opinion."
-- Harlan Ellison
%
"It's curtains for you, Mighty Mouse!  This gun is so futuristic that even
*I* don't know how it works!"
-- from Ralph Bakshi's Mighty Mouse
%
"May the forces of evil become confused on the way to your house."
-- George Carlin
%
A university faculty is 500 egotists with a common parking problem.
%
   "Daddy, Daddy, make
    Santa Claus go away!"
         "I can't, son;
   he's grown too
   powerful."
         "HO HO HO!"
-- Duck's Breath Mystery Theatre
%
"If it's not loud, it doesn't work!"
-- Blank Reg, from "Max Headroom"
%
"Remember kids, if there's a loaded gun in the room, be sure that you're the
one holding it"
-- Captain Combat
%
Delta: We never make the same mistake three times.   -- David Letterman
%
Delta: A real man lands where he wants to.   -- David Letterman
%
Delta: The kids will love our inflatable slides.    -- David Letterman
%
Delta: We're Amtrak with wings.    -- David Letterman
%
"Where humor is concerned there are no standards -- no one can say what is
good or bad, although you can be sure that everyone will.
 -- John Kenneth Galbraith
%
"Hello again, Peabody here..."
-- Mister Peabody
%
"It's the best thing since professional golfers on 'ludes."
-- Rick Obidiah
%
"To your left is the marina where several senior cabinet officials keep luxury
yachts for weekend cruises on the Potomac.  Some of these ships are up to 100
feet in length; the Presidential yacht is over 200 feet in length, and can
remain submerged for up to 3 weeks."
-- Garrison Keillor
%
"Well, social relevance is a schtick, like mysteries, social relevance,
science fiction..."
-- Art Spiegelman
%
"One of the problems I've always had with propaganda pamphlets is that they're
real boring to look at.  They're just badly designed.  People from the left
often are very well-intended, but they never had time to take basic design
classes, you know?"
-- Art Spiegelman
%
"If you took everyone who's ever been to a Dead
 show, and lined them up, they'd stretch halfway to
 the moon and back... and none of them would be
 complaining."
-- a local Deadhead in the Seattle Times
%
"And remember: Evil will always prevail, because Good is dumb."
-- Spaceballs
%
Why are many scientists using lawyers for medical
experiments instead of rats?

 a)  There are more lawyers than rats.
 b)  The scientist's don't become as
      emotionally attached to them.
 c)  There are some things that even rats
     won't do for money.
%
 "During the race
  We may eat your dust,
  But when you graduate,
  You'll work for us."
 -- Reed College cheer
%
Pohl's law:
  Nothing is so good that somebody, somewhere, will not hate it.
%
Pig: An animal (Porcus omnivorous) closely allied to the human race by the
splendor and vivacity of its appetite, which, however, is inferior in scope,
for it balks at pig.
-- Ambrose Bierce
%
"We don't have to protect the environment -- the Second Coming is at hand."
-- James Watt
%
"I believe that Ronald Reagan will someday make this
 country what it once was... an arctic wilderness."
-- Steve Martin
%
"To YOU I'm an atheist; to God, I'm the Loyal Opposition."
-- Woody Allen
%
Noncombatant:  A dead Quaker.
-- Ambrose Bierce
%
"There's only one way to have a happy marriage and as soon as I learn what it
is I'll get married again."
-- Clint Eastwood
%
A lot of people I know believe in positive thinking, and so do I.
I believe everything positively stinks.
-- Lew Col
%
Q:  How many IBM CPU's does it take to execute a job?
A:  Four; three to hold it down, and one to rip its head off.
%
Diplomacy is the art of saying "nice doggy" until you can find a rock.
%
Harrisberger's Fourth Law of the Lab:
 Experience is directly proportional to the
 amount of equipment ruined.
%
Captain Penny's Law:
 You can fool all of the people some of the
 time, and some of the people all of the
 time, but you can't fool mom.
%
"Because he's a character who's looking for his own identity, [He-Man is]
an interesting role for an actor."
-- Dolph Lundgren, "actor"
%
"If Jesus came back today, and saw what was going on in his name, he'd never
stop throwing up."
-- Max Von Sydow's character in "Hannah and Her Sisters"
%
"Nietzsche says that we will live the same life, over and over again.
God -- I'll have to sit through the Ice Capades again."
-- Woody Allen's character in "Hannah and Her Sisters"
%
"In regards to Oral Roberts' claim that God told him that he would die unless he
 received $20 million by March, God's lawyers have stated that their client has
 not spoken with Roberts for several years.  Off the record, God has stated that
 "If I had wanted to ice the little toad, I would have done it a long time ago."
-- Dennis Miller, SNL News
%
"Only the hypocrite is really rotten to the core."
-- Hannah Arendt.
%
Quod licet Iovi non licet bovi.
(What Jove may do, is not permitted to a cow.)
%
"I distrust a man who says 'when.'  If he's got to be careful not to drink too
much, it's because he's not to be trusted when he does."
-- Sidney Greenstreet, _The Maltese Falcon_
%
"I distrust a close-mouthed man.  He generally picks the wrong time to talk
and says the wrong things.  Talking's something you can't do judiciously,
unless you keep in practice.  Now, sir, we'll talk if you like. I'll tell
you right out, I'm a man who likes talking to a man who likes to talk."
-- Sidney Greenstreet, _The Maltese Falcon_
%
All extremists should be taken out and shot.
%
"The sixties were good to you, weren't they?"
-- George Carlin
%
"You stay here, Audrey -- this is between me and the vegetable!"
-- Seymour, from _Little Shop Of Horrors_
%
From Sharp minds come... pointed heads.
-- Bryan Sparrowhawk
%
There are two kinds of egotists: 1) Those who admit it  2) The rest of us
%
"The picture's pretty bleak, gentlemen...  The world's climates are changing,
the mammals are taking over, and we all have a brain about the size of a
walnut."
-- some dinosaurs from The Far Side, by Gary Larson
%
"We Americans, we're a simple people... but piss us off, and we'll bomb
your cities."
-- Robin Williams, _Good Morning Vietnam_
%
Why won't sharks eat lawyers?   Professional courtesy.
%
"You know, we've won awards for this crap."
-- David Letterman
%
It was pity stayed his hand.
"Pity I don't have any more bullets," thought Frito.
-- _Bored_of_the_Rings_, a Harvard Lampoon parody of Tolkein
%
A good USENET motto would be:
 a. "Together, a strong community."
 b. "Computers R Us."
 c. "I'm sick of programming, I think I'll just screw around for a while on
     company time."
-- A Sane Man
%
"He didn't run for reelection. `Politics brings you into contact with all the
people you'd give anything to avoid,' he said. `I'm staying home.'"
-- Garrison Keillor, _Lake_Wobegone_Days_
%
"If you lived today as if it were your last, you'd buy up a box of rockets and
fire them all off, wouldn't you?"
-- Garrison Keillor
%
"Mr. Spock succumbs to a powerful mating urge and nearly kills Captain Kirk."
-- TV Guide, describing the Star Trek episode _Amok_Time_
%
"Poor man... he was like an employee to me."
-- The police commisioner on "Sledge Hammer" laments the death of his bodyguard
%
"Trust me.  I know what I'm doing."
-- Sledge Hammer
%
"Hi.  This is Dan Cassidy's answering machine.  Please leave your name and
number... and after I've doctored the tape, your message will implicate you
 in a federal crime and be brought to the attention of the F.B.I... BEEEP"
 -- Blue Devil comics
%
"All God's children are not beautiful. Most of God's children are, in fact,
barely presentable."
-- Fran Lebowitz
%
"If truth is beauty, how come no one has their hair done in the library?"
-- Lily Tomlin
%
Whom the gods would destroy, they first teach BASIC.
%
"Look! There! Evil!.. pure and simple, total evil from the Eighth Dimension!"
-- Buckaroo Banzai
%
"I may be synthetic, but I'm not stupid"
-- the artificial person, from _Aliens_
%
"The only way I can lose this election is if I'm caught in bed with a dead
girl or a live boy."
-- Louisiana governor Edwin Edwards
%
David Letterman's "Things we can be proud of as Americans":
 * Greatest number of citizens who have actually boarded a UFO
 * Many newspapers feature "JUMBLE"
 * Hourly motel rates
 * Vast majority of Elvis movies made here
 * Didn't just give up right away during World War II like some
     countries we could mention
 * Goatees & Van Dykes thought to be worn only by weenies
 * Our well-behaved golf professionals
 * Fabulous babes coast to coast
%
"Danger, you haven't seen the last of me!"
   "No, but the first of you turns my stomach!"
-- The Firesign Theatre's Nick Danger
%
Pray to God, but keep rowing to shore.
 -- Russian Proverb
%
"Don't worry about people stealing your ideas.  If your ideas are any good,
you'll have to ram them down people's throats."
 -- Howard Aiken
%
"When anyone says `theoretically,' they really mean `not really.'"
 -- David Parnas
%
"No problem is so formidable that you can't walk away from it."
 -- C. Schulz
%
"The good Christian should beware of mathematicians and all those who make
empty prophecies.  The danger already exists that mathematicians have made
a covenant with the devil to darken the spirit and confine man in the
bonds of Hell."
 -- Saint Augustine
%
"For the man who has everything... Penicillin."
 -- F. Borquin
%
 "I've finally learned what `upward compatible' means. It means we
  get to keep all our old mistakes."
 -- Dennie van Tassel
%
"The way of the world is to praise dead saints and prosecute live ones."
 -- Nathaniel Howe
%
"It's a dog-eat-dog world out there, and I'm wearing Milkbone underware."
-- Norm, from _Cheers_
%
Once at a social gathering, Gladstone said to Disraeli, "I predict, Sir, that
you will die either by hanging or of some vile disease".  Disraeli replied,
"That all depends, Sir, upon whether I embrace your principles or your
mistress."
%
"He don't know me vewy well, DO he?"   -- Bugs Bunny
%
"I'll rob that rich person and give it to some poor deserving slob.
 That will *prove* I'm Robin Hood."
-- Daffy Duck, Looney Tunes, _Robin Hood Daffy_
%
"Would I turn on the gas if my pal Mugsy were in there?"
   "You might, rabbit, you might!"
-- Looney Tunes, Bugs and Thugs (1954, Friz Freleng)
%
"Consequences, Schmonsequences, as long as I'm rich."
-- Looney Tunes, Ali Baba Bunny (1957, Chuck Jones)
%
"And do you think (fop that I am) that I could be the Scarlet Pumpernickel?"
-- Looney Tunes, The Scarlet Pumpernickel (1950, Chuck Jones)
%
"Now I've got the bead on you with MY disintegrating gun.  And when it
disintegrates, it disintegrates.  (pulls trigger)  Well, what you do know,
it disintegrated."
-- Duck Dodgers in the 24th and a half century
%
"Kill the Wabbit, Kill the Wabbit, Kill the Wabbit!"
-- Looney Tunes, "What's Opera Doc?" (1957, Chuck Jones)
%
"I DO want your money, because god wants your money!"
-- The Reverend Jimmy, from _Repo_Man_
%
"The majority of the stupid is invincible and guaranteed for all time. The
terror of their tyranny, however, is alleviated by their lack of consistency."
-- Albert Einstein
%
"You show me an American who can keep his mouth shut and I'll eat him."
-- Newspaperman from Frank Capra's _Meet_John_Doe_
%
 "And we heard him exclaim
  As he started to roam:
  `I'm a hologram, kids,
   please don't try this at home!'"
 -- Bob Violence
-- Howie Chaykin's little animated 3-dimensional darling, Bob Violence
%
"The Soviet Union, which has complained recently about alleged anti-Soviet
themes in American advertising, lodged an official protest this week against
the Ford Motor Company's new campaign: `Hey you stinking fat Russian, get
 off my Ford Escort.'"
-- Dennis Miller, Saturday Night Live
%
"There is hopeful symbolism in the fact that flags do not wave in a vacuum."
--Arthur C. Clarke
%
"They ought to make butt-flavored cat food."   --Gallagher
%
"Not only is God dead, but just try to find a plumber on weekends."
--Woody Allen
%
"It's ten o'clock... Do you know where your AI programs are?"  -- Peter Oakley
%
"Ah, you know the type.  They like to blame it all on the Jews or the Blacks,
'cause if they couldn't, they'd have to wake up to the fact that life's one big,
scary, glorious, complex and ultimately unfathomable crapshoot -- and the only
reason THEY can't seem to keep up is they're a bunch of misfits and losers."
-- an analysis of neo-Nazis and such, Badger comics
%
"Interesting survey in the current Journal of Abnormal Psychology: New York
City has a higher percentage of people you shouldn't make any sudden moves
around than any other city in the world."
-- David Letterman
%
"Tourists -- have some fun with New york's hard-boiled cabbies.  When you get
to your destination, say to your driver, "Pay? I was hitchhiking."
-- David Letterman
%
"An anthropologist at Tulane has just come back from a field trip to New
Guinea with reports of a tribe so primitive that they have Tide but not
new Tide with lemon-fresh Borax."
-- David Letterman
%
"Based on what you know about him in history books, what do you think Abraham
Lincoln would be doing if he were alive today?
 1) Writing his memoirs of the Civil War.
 2) Advising the President.
 3) Desperately clawing at the inside of his
    coffin."
-- David Letterman
%
"If Ricky Schroder and Gary Coleman had a fight on
 television with pool cues, who would win?
 1) Ricky Schroder
 2) Gary Coleman
 3) The television viewing public"
-- David Letterman
%
"If you are beginning to doubt what I am saying, you are
 probably hallucinating."
-- The Firesign Theatre, _Everything you know is Wrong_
%
What to do in case of an alien attack:

    1)   Hide beneath the seat of your plane and look away.
    2)   Avoid eye contact.
    3) If there are no eyes, avoid all contact.

-- The Firesign Theatre, _Everything you know is Wrong_
%
"Nuclear war would really set back cable."
- Ted Turner
%
"You tweachewous miscweant!"
-- Elmer Fudd
%
"I saw _Lassie_. It took me four shows to figure out why the hairy kid never
spoke. I mean, he could roll over and all that, but did that deserve a series?"
-- the alien guy, in _Explorers_
%
"Open Channel D..."
-- Napoleon Solo, The Man From U.N.C.L.E.
%
Save the whales.  Collect the whole set.
%
Support Mental Health.  Or I'll kill you.
%
"The pyramid is opening!"
   "Which one?"
"The one with the ever-widening hole in it!"
-- The Firesign Theatre
%
"Calling J-Man Kink.  Calling J-Man Kink.  Hash missile sighted, target
Los Angeles.  Disregard personal feelings about city and intercept."
-- The Firesign Theatre movie, _J-Men Forever_
%
"My sense of purpose is gone! I have no idea who I AM!"
    "Oh, my God... You've.. You've turned him into a DEMOCRAT!"
-- Doonesbury
%
"You are WRONG, you ol' brass-breasted fascist poop!"
-- Bloom County
%
"Well, if you can't believe what you read in a comic book, what *can*
you believe?!"
-- Bullwinkle J. Moose
%
"Your mother was a hamster, and your father smelt of elderberrys!"
-- Monty Python and the Holy Grail
%
"Take that, you hostile sons-of-bitches!"
-- James Coburn, in the finale of _The_President's_Analyst_
%
"The voters have spoken, the bastards..."
-- unknown
%
"I prefer to think that God is not dead, just drunk"
-- John Huston
%
"Be there.  Aloha."
-- Steve McGarret, _Hawaii Five-Oh_
%
"When the going gets weird, the weird turn pro..."
-- Hunter S. Thompson
%
"Say yur prayers, yuh flea-pickin' varmint!"
-- Yosemite Sam
%
"There... I've run rings 'round you logically"
-- Monty Python's Flying Circus
%
"Let's show this prehistoric bitch how we do things downtown!"
-- The Ghostbusters
%
...Veloz is indistinguishable from hundreds of other electronics businesses
in the Valley, run by eager young engineers poring over memory dumps late
into the night.  The difference is that a bunch of self-confessed "car nuts"
are making money doing what they love: writing code and driving fast.
-- "Electronics puts its foot on the gas", IEEE Spectrum, May 88
%
"Just the facts, Ma'am"
-- Joe Friday
%
"I have five dollars for each of you."
-- Bernhard Goetz
%
Mausoleum:  The final and funniest folly of the rich.
-- Ambrose Bierce
%
Riches:  A gift from Heaven signifying, "This is my beloved son, in whom I
am well pleased."
-- John D. Rockefeller, (slander by Ambrose Bierce)
%
All things are either sacred or profane.
The former to ecclesiasts bring gain;
The latter to the devil appertain.
-- Dumbo Omohundro
%
Saint:  A dead sinner revised and edited.
-- Ambrose Bierce
%
Forty two.
%
Meekness:  Uncommon patience in planning a revenge that is worth while.
-- Ambrose Bierce
%
Absolute:  Independent, irresponsible.  An absolute monarchy is one in which
the sovereign does as he pleases so long as he pleases the assassins.  Not
many absolute monarchies are left, most of them having been replaced by
limited monarchies, where the soverign's power for evil (and for good) is
greatly curtailed, and by republics, which are governed by chance.
-- Ambrose Bierce
%
Abstainer:  A weak person who yields to the temptation of denying himself a
pleasure.  A total abstainer is one who abstains from everything but
abstention, and especially from inactivity in the affairs of others.
-- Ambrose Bierce
%
Alliance:  In international politics, the union of two thieves who have their
hands so deeply inserted in each other's pocket that they cannot separately
plunder a third.
-- Ambrose Bierce
%
Disobedience:  The silver lining to the cloud of servitude.
-- Ambrose Bierce
%
Egotist:  A person of low taste, more interested in himself than in me.
-- Ambrose Bierce
%
Administration:  An ingenious abstraction in politics, designed to receive
the kicks and cuffs due to the premier or president.
-- Ambrose Bierce
%
A penny saved is a penny to squander.
-- Ambrose Bierce
%
Ocean:  A body of water occupying about two-thirds of a world made for man --
who has no gills.
-- Ambrose Bierce
%
Physician:  One upon whom we set our hopes when ill and our dogs when well.
-- Ambrose Bierce
%
Philosophy:  A route of many roads leading from nowhere to nothing.
-- Ambrose Bierce
%
Politics:  A strife of interests masquerading as a contest of principles.
The conduct of public affairs for private advantage.
-- Ambrose Bierce
%
Politician:  An eel in the fundamental mud upon which the superstructure of
organized society is reared.  When he wriggles he mistakes the agitation of
his tail for the trembling of the edifice.  As compared with the statesman,
he suffers the disadvantage of being alive.
-- Ambrose Bierce
%
Pray:  To ask that the laws of the universe be annulled in behalf of a single
petitioner confessedly unworthy.
-- Ambrose Bierce
%
Presidency:  The greased pig in the field game of American politics.
-- Ambrose Bierce
%
Proboscis:  The rudimentary organ of an elephant which serves him in place
of the knife-and-fork that Evolution has as yet denied him.  For purposes
of humor it is popularly called a trunk.
-- Ambrose Bierce
%
Inadmissible:  Not competent to be considered.  Said of certain kinds of
testimony which juries are supposed to be unfit to be entrusted with,
and which judges, therefore, rule out, even of proceedings before themselves
alone.  Hearsay evidence is inadmissible because the person quoted was
unsworn and is not before the court for examination; yet most momentous
actions, military, political, commercial and of every other kind, are
daily undertaken on hearsay evidence.  There is no religion in the world
that has any other basis than hearsay evidence.  Revelation is hearsay
evidence; that the Scriptures are the word of God we have only the
testimony of men long dead whose identy is not clearly established and
who are not known to have been sworn in any sense.  Under the rules of
evidence as they now exist in this country, no single assertion in the
Bible has in its support any evidence admissible in a court of law...

But as records of courts of justice are admissible, it can easily be proved
that powerful and malevolent magicians once existed and were a scourge to
mankind.  The evidence (including confession) upon which certain women
were convicted of witchcraft and executed was without a flaw; it is still
unimpeachable.  The judges' decisions based on it were sound in logic and
in law.  Nothing in any existing court was ever more thoroughly proved than
the charges of witchcraft and sorcery for which so many suffered death.
If there were no witches, human testimony and human reason are alike
destitute of value.  --Ambrose Bierce
%
"Today's robots are very primitive, capable of understanding only a few
 simple instructions such as 'go left', 'go right', and 'build car'."
 --John Sladek
%
"In the fight between you and the world, back the world."
 --Frank Zappa
%
Here is an Appalachian version of management's answer to those who are
concerned with the fate of the project:
"Don't worry about the mule.  Just load the wagon."
-- Mike Dennison's hillbilly uncle
%
Ill-chosen abstraction is particularly evident in the design of the ADA
runtime system. The interface to the ADA runtime system is so opaque that
it is impossible to model or predict its performance, making it effectively
useless for real-time systems. -- Marc D. Donner and David H. Jameson.
%
"Being against torture ought to be sort of a bipartisan thing."
-- Karl Lehenbauer
%
"Here comes Mr. Bill's dog."
-- Narrator, Saturday Night Live
%
Sex is like air.  It's only a big deal if you can't get any.
%
"Maintain an awareness for contribution -- to your schedule, your project,
our company."
-- A Group of Employees
%
"Ask not what A Group of Employees can do for you.  But ask what can
All Employees do for A Group of Employees."
-- Mike Dennison
%
One evening Mr. Rudolph Block, of New York, found himself seated at dinner
alongside Mr. Percival Pollard, the distinguished critic.
   "Mr. Pollard," said he, "my book, _The Biography of a Dead Cow_, is
 published anonymously, but you can hardly be ignorant of its authorship.
 Yet in reviewing it you speak of it as the work of the Idiot of the Century.
 Do you think that fair criticism?"
   "I am very sorry, sir," replied the critic, amiably, "but it did not
occur to me that you really might not wish the public to know who wrote it."
-- Ambrose Bierce
%
Many aligators will be slain,
but the swamp will remain.
%
What the gods would destroy they first submit to an IEEE standards committee.
%
This is now.  Later is later.
%
"I will make no bargains with terrorist hardware."
-- Peter da Silva
%
"If I do not return to the pulpit this weekend, millions of people will go
to hell."
-- Jimmy Swaggart, 5/20/88
%
"Dump the condiments.  If we are to be eaten, we don't need to taste good."
-- "Visionaries" cartoon
%
"Aww, if you make me cry anymore, you'll fog up my helmet."
-- "Visionaries" cartoon
%
I don't want to be young again, I just don't want to get any older.
%
Marriage Ceremony:  An incredible metaphysical sham of watching God and the
law being dragged into the affairs of your family.
-- O. C. Ogilvie
%
  "Emergency!"  Sgiggs screamed, ejecting himself from the tub like it was
a burning car.  "Dial 'one'!  Get room service!  Code red!"  Stiggs was on
the phone immediately, ordering more rose blossoms, because, according to
him, the ones floating in the tub had suddenly lost their smell.  "I demand
smell," he shrilled.  "I expecting total uninterrupted smell from these
f*cking roses."

  Unfortunately, the service captain didn't realize that the Stiggs situation
involved fifty roses.  "What am I going to do with this?" Stiggs sneered at
the weaseling hotel goon when he appeared at our door holding a single flower
floating in a brandy glass.  Stiggs's tirade was great.  "Do you see this
bathtub?  Do you notice any difference between the size of the tub and the
size of that spindly wad of petals in your hand?  I need total bath coverage.
I need a completely solid layer of roses all around me like puffing factories
of smell, attacking me with their smell and power-ramming big stinking
concentrations of rose odor up my nostrils until I'm wasted with pleasure."
It wasn't long before we got so dissatisfied with this incompetence that we
bolted.
-- The Utterly Monstrous, Mind-Roasting Summer of O.C. and Stiggs,
   National Lampoon, October 1982
%
When it is incorrect, it is, at least *authoritatively* incorrect.
-- Hitchiker's Guide To The Galaxy
%
We decided it was night again, so we camped for twenty minutes and drank
another six beers at a Young Life campsite.  O.C. got into the supervisory
adult's sleeping bag and ran around in it.  "This is the judgment day and I'm
a terrifying apparition," he screamed.  Then the heat made O.C. ralph in the
bag.
-- The Utterly Monstrous, Mind-Roasting Summer of O.C. and Stiggs,
   National Lampoon, October 1982
%
Voodoo Programming:  Things programmers do that they know shouldn't work but
they try anyway, and which sometimes actually work, such as recompiling
everything.
-- Karl Lehenbauer
%
This is, of course, totally uninformed specualation that I engage in to help
support my bias against such meddling... but there you have it.
-- Peter da Silva, speculating about why a computer program that had been
changed to do something he didn't approve of, didn't work
%
"This knowledge I pursure is the finest pleasure I have ever known.  I could
no sooner give it up that I could the very air that I breath."
-- Paolo Uccello, Renaissance artist, discoverer of the laws of perspective
%
"I got everybody to pay up front...then I blew up their planet."
  "Now why didn't I think of that?"
-- Post Bros. Comics
%
"Atomic batteries to power, turbines to speed."
-- Robin, The Boy Wonder
%
The F-15 Eagle:
 If it's up, we'll shoot it down.  If it's down, we'll blow it up.
-- A McDonnel-Douglas ad from a few years ago
%
"The Amiga is the only personal computer where you can run a multitasking
operating system and get realtime performance, out of the box."
-- Peter da Silva
%
"It's my cookie file and if I come up with something that's lame and I like it,
it goes in."
-- karl (Karl Lehenbauer)
%
In recognizing AT&T Bell Laboratories for corporate innovation, for its
invention of cellular mobile communications, IEEE President Russell C. Drew
referred to the cellular telephone as a "basic necessity."  How times have
changed, one observer remarked: many in the room recalled the advent of
direct dialing.
-- The Institute, July 1988, pg. 11
%
...the Soviets have the capability to try big projects.  If there is a goal,
such as when Gorbachev states that they are going to have nuclear-powered
aircraft carriers, the case is closed -- that is it.  They will concentrate
on the problem, do a bad job, and later pay the price.  They really don't
care what the price is.
-- Victor Belenko, MiG-25 fighter pilot who defected in 1976
   "Defense Electronics", Vol 20, No. 6, pg. 100
%
There is something you must understand about the Soviet system.  They have the
ability to concentrate all their efforts on a given design, and develop all
components simulateously, but sometimes without proper testing.  Then they end
up with a technological disaster like the Tu-144.  In a technology race at
the time, that aircraft was two months ahead of the Concorde.  Four Tu-144s
were built; two have crashed, and two are in museums.  The Concorde has been
flying safely for over 10 years.
-- Victor Belenko, MiG-25 fighter pilot who defected in 1976
   "Defense Electronics", Vol 20, No. 6, pg. 100
%
DE:  The Soviets seem to have difficulty implementing modern technology.
     Would you comment on that?

Belenko:  Well, let's talk about aircraft engine lifetime.  When I flew the
   MiG-25, its engines had a total lifetime of 250 hours.

DE:  Is that mean-time-between-failure?

Belenko:  No, the engine is finished; it is scrapped.

DE:  You mean they pull it out and throw it away, not even overhauling it?

Belenko:  That is correct.  Overhaul is too expensive.

DE:  That is absurdly low by free world standards.

Belenko:  I know.
-- an interview with Victor Belenko, MiG-25 fighter pilot who defected in 1976
   "Defense Electronics", Vol 20, No. 6, pg. 102
%
"I have a friend who just got back from the Soviet Union, and told me the people
there are hungry for information about the West.  He was asked about many
things, but I will give you two examples that are very revealing about life in
the Soviet Union.  The first question he was asked was if we had exploding
television sets.  You see, they have a problem with the picture tubes on color
television sets, and many are exploding.  They assumed we must be having
problems with them too.  The other question he was asked often was why the
CIA had killed Samantha Smith, the little girl who visited the Soviet Union a
few years ago; their propaganda is very effective.
-- Victor Belenko, MiG-25 fighter pilot who defected in 1976
   "Defense Electronics", Vol 20, No. 6, pg. 100
%
"...I could accept this openness, glasnost, perestroika, or whatever you want
to call it if they did these things: abolish the one party system; open the
Soviet frontier and allow Soviet people to travel freely; allow the Soviet
people to have real free enterprise; allow Western businessmen to do business
there, and permit freedom of speech and of the press.  But so far, the whole
country is like a concentration camp.  The barbed wire on the fence around
the Soviet Union is to keep people inside, in the dark.  This openness that
you are seeing, all these changes, are cosmetic and they have been designed
to impress shortsighted, naive, sometimes stupid Western leaders.  These
leaders gush over Gorbachev, hoping to do business with the Soviet Union or
appease it.  He will say: "Yes, we can do business!"  This while his
military machine in Afghanistan has killed over a million people out of a
population of 17 million.  Can you imagine that?
-- Victor Belenko, MiG-25 fighter pilot who defected in 1976
   "Defense Electronics", Vol 20, No. 6, pg. 110
%
"Remember Kruschev:  he tried to do too many things too fast, and he was
removed in disgrace.  If Gorbachev tries to destroy the system or make too
many fundamental changes to it, I believe the system will get rid of him.
I am not a political scientist, but I understand the system very well.
I believe he will have a "heart attack" or retire or be removed.  He is
up against a brick wall.  If you think they will change everything and
become a free, open society, forget it!"
-- Victor Belenko, MiG-25 fighter pilot who defected in 1976
   "Defense Electronics", Vol 20, No. 6, pg. 110
%
FORTRAN?  The syntactically incorrect statement "DO 10 I = 1.10" will parse and
generate code creating a variable, DO10I, as follows: "DO10I = 1.10"  If that
doesn't terrify you, it should.
%
"I knew then (in 1970) that a 4-kbyte minicomputer would cost as much as
a house.  So I reasoned that after college, I'd have to live cheaply in
an apartment and put all my money into owning a computer."
-- Apple co-founder Steve Wozniak, EE Times, June 6, 1988, pg 45
%
HP had a unique policy of allowing its engineers to take parts from stock as
long as they built something.  "They figured that with every design, they were
getting a better engineer.  It's a policy I urge all companies to adopt."
-- Apple co-founder Steve Wozniak, "Will Wozniak's class give Apple to teacher?"
   EE Times, June 6, 1988, pg 45
%
"I just want to be a good engineer."
-- Steve Wozniak, co-founder of Apple Computer, concluding his keynote speech
   at the 1988 AppleFest
%
"There's always been Tower of Babel sort of bickering inside Unix, but this
is the most extreme form ever.  This means at least several years of confusion."
-- Bill Gates, founder and chairman of Microsoft,
   about the Open Systems Foundation
%
"When in doubt, print 'em out."
-- Karl's Programming Proverb 0x7
%
"If you want the best things to happen in corporate life you have to find ways
to be hospitable to the unusual person.  You don't get innovation as a
democratic process.  You almost get it as an anti-democratic process.
Certainly you get it as an anthitetical process, so you have to have an
environment where the body of people are really amenable to change and can
deal with the conflicts that arise out of change an innovation."
-- Max DePree, chairman and CEO of Herman Miller Inc.,
   "Herman Miller's Secrets of Corporate Creativity",
   The Wall Street Journal, May 3, 1988
%
"In corporate life, I think there are three important areas which contracts
can't deal with, the area of conflict, the area of change and area of reaching
potential.  To me a covenant is a relationship that is based on such things
as shared ideals and shared value systems and shared ideas and shared
agreement as to the processes we are going to use for working together.  In
many cases they develop into real love relationships."
-- Max DePree, chairman and CEO of Herman Miller Inc., "Herman Miller's
   Secrets of Corporate Creativity", The Wall Street Journal, May 3, 1988
%
Another goal is to establish a relationship "in which it is OK for everybody
to do their best.  There are an awful lot of people in management who really
don't want subordinates to do their best, because it gets to be very
threatening.  But we have found that both internally and with outside
designers if we are willing to have this kind of relationship and if we're
willing to be vulnerable to what will come out of it, we get really good
work."
-- Max DePree, chairman and CEO of Herman Miller Inc., "Herman Miller's
   Secrets of Corporate Creativity", The Wall Street Journal, May 3, 1988
%
In his book, Mr. DePree tells the story of how designer George Nelson urged
that the company also take on Charles Eames in the late 1940s.  Max's father,
J. DePree, co-founder of the company with herman Miller in 1923, asked Mr.
Nelson if he really wanted to share the limited opportunities of a then-small
company with another designer.  "George's response was something like this:
'Charles Eames is an unusual talent.  He is very different from me.  The
company needs us both.  I want very much to have Charles Eames share in
whatever potential there is.'"
-- Max DePree, chairman and CEO of Herman Miller Inc., "Herman Miller's
   Secrets of Corporate Creativity", The Wall Street Journal, May 3, 1988
%
Mr. DePree believes participative capitalism is the wave of the future.  The
U.S. work force, he believes, "more and more demands to be included in the
capitalist system and if we don't find ways to get the capitalist system
to be an inclusive system rather than the exclusive system it has been, we're
all in deep trouble.  If we don't find ways to begin to understand that
capitalism's highest potential lies in the common good, not in the individual
good, then we're risking the system itself."
-- Max DePree, chairman and CEO of Herman Miller Inc., "Herman Miller's
   Secrets of Corporate Creativity", The Wall Street Journal, May 3, 1988
%
Mr. DePree also expects a "tremendous social change" in all workplaces.  "When
I first started working 40 years ago, a factory supervisor was focused on the
product.  Today it is drastically different, because of the social milieu.
It isn't unusual for a worker to arrive on his shift and have some family
problem that he doesn't know how to resolve.  The example I like to use is a
guy who comes in and says 'this isn't going to be a good day for me, my son
is in jail on a drunk-driving charge and I don't know how to raise bail.'
What that means is that if the supervisor wants productivity, he has to know
how to raise bail."
-- Max DePree, chairman and CEO of Herman Miller Inc., "Herman Miller's
   Secrets of Corporate Creativity", The Wall Street Journal, May 3, 1988
%
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
%
"What if" is a trademark of Hewlett Packard, so stop using it in your
sentences without permission, or risk being sued.
%
Now, if the leaders of the world -- people who are leaders by virtue of
political, military or financial power, and not necessarily wisdom or
consideration for mankind -- if these leaders manage not to pull us
over the brink into planetary suicide, despite their occasional pompous
suggestions that they may feel obliged to do so, we may survive beyond
1988.
-- George Rostky, EE Times, June 20, 1988 p. 45
%
The essential ideas of Algol 68 were that the whole language should be
precisely defined and that all the pieces should fit together smoothly.
The basic idea behind Pascal was that it didn't matter how vague the
language specification was (it took *years* to clarify) or how many rough
edges there were, as long as the CDC Pascal compiler was fast.
-- Richard A. O'Keefe
%
"We came.  We saw.  We kicked its ass."
-- Bill Murray, _Ghostbusters_
%
"The stars are made of the same atoms as the earth."  I usually pick one small
topic like this to give a lecture on.  Poets say science takes away from the
beauty of the stars -- mere gobs of gas atoms.  Nothing is "mere."  I too can
see the stars on a desert night, and feel them.  But do I see less or more?
The vastness of the heavens stretches my imagination -- stuck on this carousel
my little eye can catch one-million-year-old light.  A vast pattern -- of which
I am a part -- perhaps my stuff was belched from some forgotten star, as one
is belching there.  Or see them with the greater eye of Palomar, rushing all
apart from some common starting point when they were perhaps all together.
What is the pattern, or the meaning, or the *why?*  It does not do harm to the
mystery to know a little about it.  For far more marvelous is the truth than
any artists of the past imagined!  Why do the poets of the present not speak
of it?  What men are poets who can speak of Jupiter if he were like a man, but
if he is an immense spinning sphere of methane and ammonia must be silent?
-- Richard P. Feynman (1918-1988)
%
If you permit yourself to read meanings into (rather than drawing meanings out
of) the evidence, you can draw any conclusion you like.
-- Michael Keith, "The Bar-Code Beast", The Skeptical Enquirer Vol 12 No 4 p 416
%
"Pseudocode can be used to some extent to aid the maintenance
process.  However, pseudocode that is highly detailed -
approaching the level of detail of the code itself - is not of
much use as maintenance documentation.  Such detailed
documentation has to be maintained almost as much as the code,
thus doubling the maintenance burden.  Furthermore, since such
voluminous pseudocode is too distracting to be kept in the
listing itself, it must be kept in a separate folder.  The
result: Since pseudocode - unlike real code - doesn't have to be
maintained, no one will maintain it.  It will soon become out of
date and everyone will ignore it.  (Once, I did an informal
survey of 42 shops that used pseudocode.  Of those 42, 0 [zero!],
found that it had any value as maintenance documentation."
         --Meilir Page-Jones, "The Practical Guide to Structured
           Design", Yourdon Press (c) 1988
%
"Only a brain-damaged operating system would support task switching and not
make the simple next step of supporting multitasking."
-- George McFry
%
Sigmund Freud is alleged to have said that in the last analysis the entire field
of psychology may reduce to biological electrochemistry.
%
The magician is seated in his high chair and looks upon the world with favor.
He is at the height of his powers.  If he closes his eyes, he causes the world
to disappear.  If he opens his eyes, he causes the world to come back.  If
there is harmony within him, the world is harmonious.  If rage shatters his
inner harmony, the unity of the world is shattered.  If desire arises within
him, he utters the magic syllables that causes the desired object to appear.
His wishes, his thoughts, his gestures, his noises command the universe.
-- Selma Fraiberg, _The Magic Years_, pg. 107
%
An Animal that knows who it is, one that has a sense of his own identity, is
a discontented creature, doomed to create new problems for himself for the
duration of his stay on this planet.  Since neither the mouse nor the chimp
knows what is, he is spared all the vexing problems that follow this
discovery.  But as soon as the human animal who asked himself this question
emerged, he plunged himself and his descendants into an eternity of doubt
and brooding, speculation and truth-seeking that has goaded him through the
centures as reelentlessly as hunger or sexual longing.  The chimp that does
not know that he exists is not driven to discover his origins and is spared
the tragic necessity of contemplating his own end.  And even if the animal
experimenters succeed in teaching a chimp to count one hundred bananas or
to play chess, the chimp will develop no science and he will exhibit no
appreciation of beauty, for the greatest part of man's wisdom may be traced
back to the eternal questions of beginnings and endings, the quest to give
meaning to his existence, to life itself.
-- Selma Fraiberg, _The Magic Years_, pg. 193
%
A comment on schedules:
 Ok, how long will it take?
   For each manager involved in initial meetings add one month.
   For each manager who says "data flow analysis" add another month.
   For each unique end-user type add one month.
   For each unknown software package to be employed add two months.
   For each unknown hardware device add two months.
   For each 100 miles between developer and installation add one month.
   For each type of communication channel add one month.
   If an IBM mainframe shop is involved and you are working on a non-IBM
      system add 6 months.
   If an IBM mainframe shop is involved and you are working on an IBM
      system add 9 months.
Round up to the nearest half-year.
--Brad Sherman
By the way, ALL software projects are done by iterative prototyping.
Some companies call their prototypes "releases", that's all.
%
    UNIX Shell is the Best Fourth Generation Programming Language

    It is the UNIX shell that makes it possible to do applications in a small
    fraction of the code and time it takes in third generation languages.  In
    the shell you process whole files at a time, instead of only a line at a
    time.  And, a line of code in the UNIX shell is one or more programs,
    which do more than pages of instructions in a 3GL.  Applications can be
    developed in hours and days, rather than months and years with traditional
    systems.  Most of the other 4GLs available today look more like COBOL or
    RPG, the most tedious of the third generation lanaguages.

"UNIX Relational Database Management:  Application Development in the UNIX
 Environment" by Rod Manis, Evan Schaffer, and Robert Jorgensen.  Prentice
 Hall Software Series.  Brian Kerrighan, Advisor.  1988.
%
"Laugh while you can, monkey-boy."
-- Dr. Emilio Lizardo
%
"Floggings will continue until morale improves."
-- anonymous flyer being distributed at Exxon USA
%
"Hey Ivan, check your six."
-- Sidewinder missile jacket patch, showing a Sidewinder driving up the tail
 of a Russian Su-27
%
"Free markets select for winning solutions."
-- Eric S. Raymond
%
"I dislike companies that have a we-are-the-high-priests-of-hardware-so-you'll-
like-what-we-give-you attitude.  I like commodity markets in which iron-and-
silicon hawkers know that they exist to provide fast toys for software types
like me to play with..."
-- Eric S. Raymond
%
"The urge to destroy is also a creative urge."
-- Bakunin
[ed. note - I would say: The urge to destroy may sometimes be a creative urge.]
%
"A commercial, and in some respects a social, doubt has been started within the
 last year or two, whether or not it is right to discuss so openly the security
 or insecurity of locks.  Many well-meaning persons suppose that the discus-
 sion respecting the means for baffling the supposed safety of locks offers a
 premium for dishonesty, by showing others how to be dishonest.  This is a fal-
 lacy.  Rogues are very keen in their profession, and already know much more
 than we can teach them respecting their several kinds of roguery.  Rogues knew
 a good deal about lockpicking long before locksmiths discussed it among them-
 selves, as they have lately done.  If a lock -- let it have been made in what-
 ever country, or by whatever maker -- is not so inviolable as it has hitherto
 been deemed to be, surely it is in the interest of *honest* persons to know
 this fact, because the *dishonest* are tolerably certain to be the first to
 apply the knowledge practically; and the spread of knowledge is necessary to
 give fair play to those who might suffer by ignorance.  It cannot be too ear-
 nestly urged, that an acquaintance with real facts will, in the end, be better
 for all parties."
-- Charles Tomlinson's Rudimentary Treatise on the Construction of Locks,
   published around 1850
%
 In respect to lock-making, there can scarcely be such a thing as dishonesty
 of intention: the inventor produces a lock which he honestly thinks will
 possess such and such qualities; and he declares his belief to the world.
 If others differ from him in opinion concerning those qualities, it is open
 to them to say so; and the discussion, truthfully conducted, must lead to
 public advantage: the discussion stimulates curiosity, and curiosity stimu-
 lates invention.  Nothing but a partial and limited view of the question
 could lead to the opinion that harm can result: if there be harm, it will be
 much more than counterbalanced by good."
-- Charles Tomlinson's Rudimentary Treatise on the Construction of Locks,
   published around 1850.
%
"Wish not to seem, but to be, the best."
-- Aeschylus
%
"Survey says..."
-- Richard Dawson, weenie, on "Family Feud"
%
"Paul Lynde to block..."
-- a contestant on "Hollywood Squares"
%
"Little else matters than to write good code."
-- Karl Lehenbauer
%
To write good code is a worthy challenge, and a source of civilized delight.
-- stolen and paraphrased from William Safire
%
"Stupidity, like virtue, is its own reward"
-- William E. Davidsen
%
"If a computer can't directly address all the RAM you can use, it's just a toy."
-- anonymous comp.sys.amiga posting, non-sequitir
%
"Never laugh at live dragons, Bilbo you fool!" he said to himself, and it became
a favourite saying of his later, and passed into a proverb. "You aren't nearly
through this adventure yet," he added, and that was pretty true as well.
-- Bilbo Baggins, "The Hobbit" by J.R.R. Tolkien, Chapter XII
%
"A dirty mind is a joy forever."
-- Randy Kunkee
%
"You can't teach seven foot."
-- Frank Layton, Utah Jazz basketball coach, when asked why he had recruited
   a seven-foot tall auto mechanic
%
"A car is just a big purse on wheels."
-- Johanna Reynolds
%
"History is a tool used by politicians to justify their intentions."
-- Ted Koppel
%
"Gozer the Gozerian:  As the duly appointed representative of the city,
county and state of New York, I hereby order you to cease all supernatural
activities at once and proceed immediately to your place of origin or
the nearest parallel dimension, whichever is nearest."
-- Ray (Dan Akyroyd, _Ghostbusters_
%
It must be remembered that there is nothing more difficult to plan, more
doubtful of success, nor more dangerous to manage, than the creation of a
new system.  For the initiator has the enmity of all who would profit by
the preservation of the old institutions and merely lukewarm defenders in
those who would gain by the new ones.
-- Machiavelli
%
God grant me the senility to accept the things I cannot change,
The frustration to try to change things I cannot affect,
and the wisdom to tell the difference.
%
First as to speech.  That privilege rests upon the premise that
there is no proposition so uniformly acknowledged that it may not be
lawfully challenged, questioned, and debated.  It need not rest upon
the further premise that there are no propositions that are not
open to doubt; it is enough, even if there are, that in the end it is
worse to suppress dissent than to run the risk of heresy.  Hence it
has been again and again unconditionally proclaimed that there are
no limits to the privilege so far as words seek to affect only the hearers'
beliefs and not their conduct.  The trouble is that conduct is almost
always based upon some belief, and that to change the hearer's belief
will generally to some extent change his conduct, and may even evoke
conduct that the law forbids.

[cf. Learned Hand, The Spirit of Liberty, University of Chicago Press, 1952;
The Art and Craft of Judging: The Decisions of Judge Learned Hand,
edited and annotated by Hershel Shanks, The MacMillian Company, 1968.]
%
The late rebellion in Massachusetts has given more alarm than I think it
should have done.  Calculate that one rebellion in 13 states in the course
of 11 years, is but one for each state in a century and a half.  No country
should be so long without one.
-- Thomas Jefferson in letter to James Madison, 20 December 1787
%
"Nine years of ballet, asshole."
-- Shelly Long, to the bad guy after making a jump over a gorge that he
   couldn't quite, in "Outrageous Fortune"
%
You are in a maze of UUCP connections, all alike.
%
"If that man in the PTL is such a healer, why can't he make his wife's
 hairdo go down?"
-- Robin Williams
%
8)   Use common sense in routing cable.  Avoid wrapping coax around sources of
     strong electric or magnetic fields.  Do not wrap the cable around
     flourescent light ballasts or cyclotrons, for example.
-- Ethernet Headstart Product, Information and Installation Guide,
   Bell Technologies, pg. 11
%
"What a wonder is USENET; such wholesale production of conjecture from
such a trifling investment in fact."
-- Carl S. Gutekunst
%
VMS must die!
%
MS-DOS must die!
%
OS/2 must die!
%
Pournelle must die!
%
Garbage In, Gospel Out
%
"Being against torture ought to be sort of a multipartisan thing."
-- Karl Lehenbauer, as amended by Jeff Daiell, a Libertarian
%
"Facts are stupid things."
-- President Ronald Reagan
   (a blooper from his speeach at the '88 GOP convention)
%
"The argument that the literal story of Genesis can qualify as science
collapses on three major grounds: the creationists' need to invoke
miracles in order to compress the events of the earth's history into
the biblical span of a few thousand years; their unwillingness to
abandon claims clearly disproved, including the assertion that all
fossils are products of Noah's flood; and their reliance upon distortion,
misquote, half-quote, and citation out of context to characterize the
ideas of their opponents."
-- Stephen Jay Gould, "The Verdict on Creationism",
   The Skeptical Inquirer, Winter 87/88, pg. 186
%
"An ounce of prevention is worth a ton of code."
-- an anonymous programmer
%
"To IBM, 'open' means there is a modicum of interoperability among some of their
equipment."
-- Harv Masterson
%
"Just think of a computer as hardware you can program."
-- Nigel de la Tierre
%
"If you own a machine, you are in turn owned by it, and spend your time
 serving it..."
-- Marion Zimmer Bradley, _The Forbidden Tower_
%
"Everything should be made as simple as possible, but not simpler."
-- Albert Einstein
%
"Card readers?  We don't need no stinking card readers."
-- Peter da Silva (at the National Academy of Sciencies, 1965, in a
   particularly vivid fantasy)
%
Your good nature will bring unbounded happiness.
%
Semper Fi, dude.
%
Excitement and danger await your induction to tracer duty!  As a tracer,
you must rid the computer networks of slimy, criminal data thieves.
They are tricky and the action gets tough, so watch out!  Utilizing all
your skills, you'll either get your man or you'll get burned!
-- advertising for the computer game "Tracers"
%
"An entire fraternity of strapping Wall-Street-bound youth.  Hell - this
is going to be a blood bath!"
-- Post Bros. Comics
%
"Neighbors!!  We got neighbors!  We ain't supposed to have any neighbors, and
I just had to shoot one."
-- Post Bros. Comics
%
"Gotcha, you snot-necked weenies!"
-- Post Bros. Comics
%
interlard - vt., to intersperse; diversify
-- Webster's New World Dictionary Of The American Language
%
"Everybody is talking about the weather but nobody does anything about it."
-- Mark Twain
%
"How many teamsters does it take to screw in a light bulb?"
   "FIFTEEN!!  YOU GOT A PROBLEM WITH THAT?"
%
"If you weren't my teacher, I'd think you just deleted all my files."
-- an anonymous UCB CS student, to an instructor who had typed "rm -i *" to
   get rid of a file named "-f" on a Unix system.
%
"The hottest places in Hell are reserved for those who, in times of moral
crisis, preserved their neutrality."
-- Dante
%
"The medium is the message."
-- Marshall McLuhan
%
"The medium is the massage."
-- Crazy Nigel
%
"Show me a good loser, and I'll show you a loser."
-- Vince Lombardi, football coach
%
"It might help if we ran the MBA's out of Washington."
-- Admiral Grace Hopper
%
Refreshed by a brief blackout, I got to my feet and went next door.
-- Martin Amis, _Money_
%
The sprung doors parted and I staggered out into the lobby's teak and flicker.
Uniformed men stood by impassively like sentries in their trench.  I slapped
my key on the desk and nodded gravely.  I was loaded enough to be unable to
tell whether they could tell I was loaded.  Would they mind?  I was certainly
too loaded to care.  I moved to the door with boxy, schlep-shouldered strides.
-- Martin Amis, _Money_
%
I ask only one thing.  I'm understanding.  I'm mature.  And it isn't much to
ask.  I want to get back to London, and track her down, and be alone with my
Selina -- or not even alone, damn it, merely close to her, close enough to
smell her skin, to see the flecked webbing of her lemony eyes, the moulding
of her artful lips.  Just for a few precious seconds.  Just long enough to
put in one good, clean punch.  That's all I ask.
-- Martin Amis, _Money_
%
"Love may fail, but courtesy will previal."
-- A Kurt Vonnegut fan
%
New York is a jungle, they tell you.  You could go further, and say that
New York is a jungle.  New York *is a jungle.*  Beneath the columns of
the old rain forest, made of melting macadam, the mean Limpopo of swamped
Ninth Avenue bears an angry argosy of crocs and dragons, tiger fish, noise
machines, sweating rainmakers.  On the corners stand witchdoctors and
headhunters, babbling voodoo-men -- the natives, the jungle-smart natives.
And at night, under the equatorial overgrowth and heat-holding cloud
cover, you hear the ragged parrot-hoot and monkeysqueak of the sirens,
and then fires flower to ward off monsters.  Careful: the streets are
sprung with pits and nets and traps.  Hire a guide.  Pack your snakebite
gook and your blowdart serum.  Take it seriously.  You have to get a
bit jungle-wise.
-- Martin Amis, _Money_
%
Now I was heading, in my hot cage, down towards meat-market country on the
tip of the West Village.  Here the redbrick warehouses double as carcass
galleries and rat hives, the Manhattan fauna seeking its necessary
level, living or dead.  Here too you find the heavy faggot hangouts,
The Spike, the Water Closet, the Mother Load.  Nobody knows what goes on
in these places.  Only the heavy faggots know.  Even Fielding seems somewhat
vague on the question.  You get zapped and flogged and dumped on -- by
almost anybody's standards, you have a really terrible time.  The average
patron arrives at the Spike in one taxi but needs to go back to his sock
in two.  And then the next night he shows up for more.  They shackle
themselves to racks, they bask in urinals.  Their folks have a lot of
explaining to do, if you want my opinion, particularly the mums.  Sorry
to single you ladies out like this but the story must start somewhere.
A craving for hourly murder -- it can't be willed.  In the meantime,
Fielding tells me, Mother Nature looks on and taps her foot and clicks
her tongue.  Always a champion of monogamy, she is cooking up some fancy
new diseases.  She just isn't going to stand for it.
-- Martin Amis, _Money_
%
"You tried it just for once, found it alright for kicks,
 but now you find out you have a habit that sticks,
 you're an orgasm addict,
 you're always at it,
 and you're an orgasm addict."
-- The Buzzcocks
%
"There is no distinctly American criminal class except Congress."
-- Mark Twain
%
"You'll pay to know what you really think."
-- J.R. "Bob" Dobbs
%
"We live, in a very kooky time."
-- Herb Blashtfalt
%
"Pull the wool over your own eyes!"
-- J.R. "Bob" Dobbs
%
"Okay," Bobby said, getting the hang of it, "then what's the matrix?  If
she's a deck, and Danbala's a program, what's cyberspace?"
  "The world," Lucas said.
-- William Gibson, _Count Zero_
%
"Our reruns are better than theirs."
-- Nick at Nite
%
Life is a game.  Money is how we keep score.
-- Ted Turner
%
"Pay no attention to the man behind the curtain."
-- The Wizard Of Oz
%
"Pay no attention to the man behind the curtain."
-- Karl, as he stepped behind the computer to reboot it, during a FAT
%
"It ain't so much the things we don't know that get us in trouble.  It's the
things we know that ain't so."
-- Artemus Ward aka Charles Farrar Brown
%
"Don't discount flying pigs before you have good air defense."
-- jvh@clinet.FI
%
"In the long run, every program becomes rococo, and then rubble."
-- Alan Perlis
%
"Pok pok pok, P'kok!"
-- Superchicken
%
Live Free or Live in Massachusettes.
%
"You can't get very far in this world without your dossier being there first."
-- Arthur Miller
%
"Flight Reservation systems decide whether or not you exist. If your information
isn't in their database, then you simply don't get to go anywhere."
-- Arthur Miller
%
"What people have been reduced to are mere 3-D representations of their own
data."
-- Arthur Miller
%
"The Avis WIZARD decides if you get to drive a car. Your head won't touch the
pillow of a Sheraton unless their computer says it's okay."
-- Arthur Miller
%
"They know your name, address, telephone number, credit card numbers, who ELSE
is driving the car "for insurance", ...  your driver's license number. In the
state of Massachusetts, this is the same number as that used for Social
Security, unless you object to such use. In THAT case, you are ASSIGNED a
number and you reside forever more on the list of "weird people who don't give
out their Social Security Number in Massachusetts."
-- Arthur Miller
%
"Data is a lot like humans:  It is born.  Matures.  Gets married to other data,
divorced. Gets old.  One thing that it doesn't do is die.  It has to be killed."
-- Arthur Miller
%
"People should have access to the data which you have about them.  There should
 be a process for them to challenge any inaccuracies."
-- Arthur Miller
%
"Although Poles suffer official censorship, a pervasive secret
police and laws similar to those in the USSR, there are
thousands of underground publications, a legal independent
Church, private agriculture, and the East bloc's first and only
independent trade union federation, NSZZ Solidarnosc, which is
an affiliate of both the International Confederation of Free
Trade Unions and the World Confederation of Labor.  There is
literally a world of difference between Poland - even in its
present state of collapse - and Soviet society at the peak of
its "glasnost."  This difference has been maintained at great
cost by the Poles since 1944.
-- David Phillips, SUNY at Buffalo, about establishing a
   gateway from EARN (Eurpoean Academic Research Network)
   to Poland
%
"There is also a thriving independent student movement in
Poland, and thus there is a strong possibility (though no
guarantee) of making an EARN-Poland link, should it ever come
about, a genuine link - not a vacuum cleaner attachment for a
Bloc information gathering apparatus rationed to trusted
apparatchiks."
-- David Phillips, SUNY at Buffalo, about establishing a
   gateway from EARN (Eurpoean Academic Research Network)
   to Poland
%
"Do not lose your knowledge that man's proper estate is an upright posture,
an intransigent mind, and a step that travels unlimited roads."
-- John Galt, in Ayn Rand's _Atlas Shrugged_
%
Don't panic.
%
The bug stops here.
%
The bug starts here.
%
"Why waste negative entropy on comments, when you could use the same
entropy to create bugs instead?"
-- Steve Elias
%
"The pathology is to want control, not that you ever get it, because of
course you never do."
-- Gregory Bateson
%
"Your butt is mine."
-- Michael Jackson, Bad
%
Ship it.
%
"Once they go up, who cares where they come down?  That's not my department."
-- Werner von Braun
%
"When the only tool you have is a hammer, you tend to treat everything as if
it were a nail."
-- Abraham Maslow
%
"Imitation is the sincerest form of television."
-- The New Mighty Mouse
%
"The lesser of two evils -- is evil."
-- Seymour (Sy) Leon
%
"It's no sweat, Henry.  Russ made it back to Bugtown before he died.  So he'll
regenerate in a couple of days.  It's just awful sloppy of him to get killed in
the first place.  Humph!"
-- Ron Post, Post Brothers Comics
%
"An honest god is the noblest work of man.  ... God has always resembled his
creators.  He hated and loved what they hated and loved and he was invariably
found on the side of those in power. ... Most of the gods were pleased with
sacrifice, and the smell of innocent blood has ever been considered a divine
perfume."
-- Robert G. Ingersoll
%
"We are not endeavoring to chain the future but to free the present. ... We are
the advocates of inquiry, investigation, and thought. ... It is grander to think
and investigate for yourself than to repeat a creed. ... I look for the day
when *reason*, throned upon the world's brains, shall be the King of Kings and
the God of Gods.
-- Robert G. Ingersoll
%
"I honestly believe that the doctrine of hell was born in the glittering eyes
of snakes that run in frightful coils watching for their prey.  I believe
it was born with the yelping, howling, growling and snarling of wild beasts...
I despise it, I defy it, and I hate it."
-- Robert G. Ingersoll
%
"Is this foreplay?"
   "No, this is Nuke Strike.  Foreplay has lousy graphics.  Beat me again."
-- Duckert, in "Bad Rubber," Albedo #0 (comics)
%
egrep patterns are full regular expressions; it uses a fast deterministic
algorithm that sometimes needs exponential space.
-- unix manuals
%
"A mind is a terrible thing to have leaking out your ears."
-- The League of Sadistic Telepaths
%
"Life sucks, but it's better than the alternative."
-- Peter da Silva
%
If this is a service economy, why is the service so bad?
%
"I shall expect a chemical cure for psychopathic behavior by 10 A.M. tomorrow,
or I'll have your guts for spaghetti."
-- a comic panel by Cotham
%
"Even if you're on the right track, you'll get run over if you just sit there."
-- Will Rogers
%
"An open mind has but one disadvantage: it collects dirt."
-- a saying at RPI
%
"The geeks shall inherit the earth."
-- Karl Lehenbauer
%
"Beware of programmers carrying screwdrivers."
-- Chip Salzenberg
%
"Elvis is my copilot."
-- Cal Keegan
%
"The fundamental principle of science, the definition almost, is this: the
sole test of the validity of any idea is experiment."
-- Richard P. Feynman
%
How many Unix hacks does it take to change a light bulb?
   Let's see, can you use a shell script for that or does it need a C program?
%
"Don't hate me because I'm beautiful.  Hate me because I'm beautiful, smart
and rich."
-- Calvin Keegan
%
"The whole problem with the world is that fools and fanatics are always so
certain of themselves, but wiser people so full of doubts."
-- Bertrand Russell
%
Always look over your shoulder because everyone is watching and plotting
against you.
%
"Let us condemn to hellfire all those who disagree with us."
-- militant religionists everywhere
%
Baby On Board.
%
"The net result is a system that is not only binary compatible with 4.3 BSD,
but is even bug for bug compatible in almost all features."
-- Avadit Tevanian, Jr., "Architecture-Independent Virtual Memory Management
   for Parallel and Distributed Environments:  The Mach Approach"
%
"The number of Unix installations has grown to 10, with more expected."
-- The Unix Programmer's Manual, 2nd Edition, June, 1972
%
"Engineering without management is art."
-- Jeff Johnson
%
"I'm not a god, I was misquoted."
-- Lister, Red Dwarf
%
Brain off-line, please wait.
%
--
-- uunet!sugar!karl  | "We've been following your progress with considerable
-- karl@sugar.uu.net |  interest, not to say contempt."  -- Zaphod Beeblebrox IV
-- Usenet BBS (713) 438-5018



th-th-th-th-That's all, folks!

----------- cut here, don't forget to strip junk at the end, too -------------
"Psychoanalysis??  I thought this was a nude rap session!!!"
-- Zippy
%
Are you having fun yet?
%
"The vast majority of successful major crimes against property are
perpetrated by individuals abusing positions of trust."
-- Lawrence Dalzell
%
"Perhaps I am flogging a straw herring in mid-stream, but in the light of
what is known about the ubiquity of security vulnerabilities, it seems vastly
too dangerous for university folks to run with their heads in the sand."
-- Peter G. Neumann, RISKS moderator, about the Internet virus
%
"Seed me, Seymour"
-- a random number generator meets the big green mother from outer space
%
"Buy land.  They've stopped making it."
-- Mark Twain
%
"Open the pod bay doors, HAL."
-- Dave Bowman, 2001
%
"There was no difference between the behavior of a god and the operations of
pure chance..."
-- Thomas Pynchon, _Gravity's Rainbow_
%
...Saure really turns out to be an adept at the difficult art of papryomancy,
the ability to prophesy through contemplating the way people roll reefers -
the shape, the licking pattern, the wrinkles and folds or absence thereof
in the paper.  "You will soon be in love," sez Saure, "see, this line here."
"It's long, isn't it?  Does that mean --" "Length is usually intensity.
Not time."
-- Thomas Pynchon, _Gravity's Rainbow_
%
Go ahead, capitalize the T on technology, deify it if it will make you feel
less responsible -- but it puts you in with the neutered, brother, in with
the eunuchs keeping the harem of our stolen Earth for the numb and joyless
hardons of human sultans, human elite with no right at all to be where they
are --"
-- Thomas Pynchon, _Gravity's Rainbow_
%
...the prevailing Catholic odor - incense, wax, centuries of mild bleating
from the lips of the flock.
-- Thomas Pynchon, _Gravity's Rainbow_
%
...At that time [the 1960s], Bell Laboratories scientists projected that
computer speeds as high as 30 million floating-point calculations per
second (megaflops) would be needed for the Army's ballistic missile
defense system.  Many computer experts -- including a National Academy
of Sciences panel -- said achieving such speeds, even using multiple
processors, was impossible.  Today, new generation supercomputers operate
at billions of operations per second (gigaflops).
-- Aviation Week & Space Technology, May 9, 1988, "Washington Roundup", pg 13
%
backups: always in season, never out of style.
%
"There was a vague, unpleasant manginess about his appearence; he somehow
seemed dirty, though a close glance showed him as carefully shaven as an
actor, and clad in immaculate linen."
-- H.L. Mencken, on the death of William Jennings Bryan
%
Work was impossible.  The geeks had broken my spirit.  They had done too
many things wrong.  It was never like this for Mencken.  He lived like
a Prussian gambler -- sweating worse than Bryan on some nights and drunker
than Judas on others.  It was all a dehumanized nightmare...and these
raddled cretins have the gall to complain about my deadlines.
-- Hunter Thompson, "Bad Nerves in Fat City", _Generation of Swine_
%
"This generation may be the one that will face Armageddon."
-- Ronald Reagan, "People" magazine, December 26, 1985
%
... The cable had passed us by; the dish was the only hope, and eventually
we were all forced to turn to it.  By the summer of '85, the valley had more
satellite dishes per capita than an Eskimo village on the north slope of
Alaska.

Mine was one of the last to go in.  I had been nervous from the start about
the hazards of too much input, which is a very real problem with these
things.  Watching TV becomes a full-time job when you can scan 200 channels
all day and all night and still have the option of punching Night Dreams
into the video machine, if the rest of the world seems dull.
-- Hunter Thompson, "Full-time scrambling", _Generation of Swine_
%
"Call immediately.  Time is running out.  We both need to do something
monstrous before we die."
-- Message from Ralph Steadman to Hunter Thompson
%
"The only way for a reporter to look at a politician is down."
-- H.L. Mencken
%
"You don't go out and kick a mad dog.  If you have a mad dog with rabies, you
take a gun and shoot him."
-- Pat Robertson, TV Evangelist, about Muammar Kadhafy
%
David Brinkley: The daily astrological charts are precisely where, in my
  judgment, they belong, and that is on the comic page.
George Will:  I don't think astrology belongs even on the comic pages.
  The comics are making no truth claim.
Brinkley:  Where would you put it?
Will:  I wouldn't put it in the newspaper.  I think it's transparent rubbish.
  It's a reflection of an idea that we expelled from Western thought in the
  sixteenth century, that we are in the center of a caring universe.  We are
  not the center of the universe, and it doesn't care.  The star's alignment
  at the time of our birth -- that is absolute rubbish.  It is not funny to
  have it intruded among people who have nuclear weapons.
Sam Donaldson:  This isn't something new.  Governor Ronald Reagan was sworn
  in just after midnight in his first term in Sacramento because the stars
  said it was a propitious time.
Will:  They [horoscopes] are utter crashing banalities.  They could apply to
  anyone and anything.
Brinkley:  When is the exact moment [of birth]?  I don't think the nurse is
  standing there with a stopwatch and a notepad.
Donaldson:  If we're making decisions based on the stars -- that's a cockamamie
  thing.  People want to know.
-- "This Week" with David Brinkley, ABC Television, Sunday, May 8, 1988,
   excerpts from a discussion on Astrology and Reagan
%
The reported resort to astrology in the White House has occasioned much
merriment.  It is not funny.  Astrological gibberish, which means astrology
generally, has no place in a newspaper, let alone government.  Unlike comics,
which are part of a newspaper's harmless pleasure and make no truth claims,
astrology is a fraud.  The idea that it gets a hearing in government is
dismaying.
-- George Will, Washing Post Writers Group
%
Astrology is the sheerest hokum.  This pseudoscience has been around since
the day of the Chaldeans and Babylonians.  It is as phony as numerology,
phrenology, palmistry, alchemy, the reading of tea leaves, and the practice
of divination by the entrails of a goat.  No serious person will buy the
notion that our lives are influenced individually by the movement of
distant planets.  This is the sawdust blarney of the carnival midway.
-- James J. Kilpatrick, Universal Press Syndicate
%
A serious public debate about the validity of astrology?  A serious believer
in the White House?  Two of them?  Give me a break.  What stifled my laughter
is that the image fits.  Reagan has always exhibited a fey indifference toward
science.  Facts, like numbers, roll off his back.  And we've all come to
accept it.  This time it was stargazing that became a serious issue....Not
that long ago, it was Reagan's support of Creationism....Creationists actually
got equal time with evolutionists.  The public was supposed to be open-minded
to the claims of paleontologists and fundamentalists, as if the two were
scientific colleagues....It has been clear for a long time that the president
is averse to science...In general, these attitudes fall onto friendly American
turf....But at the outer edges, this skepticism about science easily turns
into a kind of naive acceptance of nonscience, or even nonsense.  The same
people who doubt experts can also believe any quackery, from the benefits of
laetrile to eye of newt to the movment of planets.  We lose the capacity to
make rational -- scientific -- judgments.  It's all the same.
-- Ellen Goodman, The Boston Globe Newspaper Company-Washington Post Writers
    Group
%
The spectacle of astrology in the White House -- the governing center of
the world's greatest scientific and military power -- is so appalling that
it defies understanding and provides grounds for great fright.  The easiest
response is to laugh it off, and to indulge in wisecracks about Civil
Service ratings for horoscope makers and palm readers and whether Reagan
asked Mikhail Gorbachev for his sign.  A contagious good cheer is the
hallmark of this presidency, even when the most dismal matters are concerned.
But this time, it isn't funny.  It's plain scary.
-- Daniel S. Greenberg, Editor, _Science and Government Report_, writing in
   "Newsday", May 5, 1988
%
[Astrology is] 100 percent hokum, Ted.  As a matter of fact, the first edition
of the Encyclopaedia Britannica, written in 1771 -- 1771! -- said that this
belief system is a subject long ago ridiculed and reviled.  We're dealing with
beliefs that go back to the ancient Babylonians.  There's nothing there....
It sounds a lot like science, it sounds like astronomy.  It's got technical
terms.  It's got jargon.  It confuses the public....The astrologer is quite
glib, confuses the public, uses terms which come from science, come from
metaphysics, come from a host of fields, but they really mean nothing.  The
fact is that astrological beliefs go back at least 2,500 years.  Now that
should be a sufficiently long time for astrologers to prove their case.  They
have not proved their case....It's just simply gibberish.  The fact is, there's
no theory for it, there are no observational data for it.  It's been tested
and tested over the centuries.  Nobody's ever found any validity to it at
all.  It is not even close to a science.  A science has to be repeatable, it
has to have a logical foundation, and it has to be potentially vulnerable --
you test it.  And in that astrology is reqlly quite something else.
-- Astronomer Richard Berendzen, President, American University, on ABC
    News "Nightline," May 3, 1988
%
Even if we put all these nagging thoughts [four embarrassing questions about
astrology] aside for a moment, one overriding question remains to be asked.
Why would the positions of celestial objects at the moment of birth have an
effect on our characters, lives, or destinies?  What force or influence,
what sort of energy would travel from the planets and stars to all human
beings and affect our development or fate?  No amount of scientific-sounding
jargon or computerized calculations by astrologers can disguise this central
problem with astrology -- we can find no evidence of a mechanism by which
celestial objects can influence us in so specific and personal a way. . . .
Some astrologers argue that there may be a still unknown force that represents
the astrological influence. . . .If so, astrological predictions -- like those
of any scientific field -- should be easily tested. . . . Astrologers always
claim to be just a little too busy to carry out such careful tests of their
efficacy, so in the last two decades scientists and statisticians have
generously done such testing for them.  There have been dozens of well-designed
tests all around the world, and astrology has failed every one of them. . . .
I propose that we let those beckoning lights in the sky awaken our interest
in the real (and fascinating) universe beyond our planet, and not let them
keep us tied to an ancient fantasy left over from a time when we huddled by
the firelight, afraid of the night.
-- Andrew Fraknoi, Executive Officer, Astronomical Society of the Pacific,
    "Why Astrology Believers Should Feel Embarrassed," San Jose Mercury
    News, May 8, 1988
%
With the news that Nancy Reagan has referred to an astrologer when planning
her husband's schedule, and reports of Californians evacuating Los Angeles
on the strength of a prediction from a sixteenth-century physician and
astrologer Michel de Notredame, the image of the U.S. as a scientific and
technological nation has taking a bit of a battering lately.  Sadly, such
happenings cannot be dismissed as passing fancies.  They are manifestations
of a well-established "anti-science" tendency in the U.S. which, ultimately,
could threaten the country's position as a technological power. . . .  The
manifest widespread desire to reject rationality and substitute a series
of quasirandom beliefs in order to understand the universe does not augur
well for a nation deeply concerned about its ability to compete with its
industrial equals.  To the degree that it reflects the thinking of a
significant section of the public, this point of view encourages ignorance
of and, indeed, contempt for science and for rational methods of approaching
truth. . . . It is becoming clear that if the U.S. does not pick itself up
soon and devote some effort to educating the young effectively, its hope of
maintaining a semblance of leadership in the world may rest, paradoxically,
with a new wave of technically interested and trained immigrants who do not
suffer from the anti-science disease rampant in an apparently decaying society.
-- Physicist Tony Feinberg, in "New Scientist," May 19, 1988
%
miracle:  an extremely outstanding or unusual event, thing, or accomplishment.
-- Webster's Dictionary
%
"The computer programmer is a creator of universes for which he alone
 is responsible. Universes of virtually unlimited complexity can be
 created in the form of computer programs."
-- Joseph Weizenbaum, _Computer Power and Human Reason_
%
"If the code and the comments disagree, then both are probably wrong."
-- Norm Schryer
%
"May your future be limited only by your dreams."
-- Christa McAuliffe
%
"It is better for civilization to be going down the drain than to be
coming up it."
-- Henry Allen
%
"Life begins when you can spend your spare time programming instead of
watching television."
-- Cal Keegan
%
Eat shit -- billions of flies can't be wrong.
%
"We never make assertions, Miss Taggart," said Hugh Akston.  "That is
the moral crime peculiar to our enemies.  We do not tell -- we *show*.
We do not claim -- we *prove*."
-- Ayn Rand, _Atlas Shrugged_
%
"I remember when I was a kid I used to come home from Sunday School and
 my mother would get drunk and try to make pancakes."
-- George Carlin
%
"My father?  My father left when I was quite young.  Well actually, he
 was asked to leave.  He had trouble metabolizing alcohol."
 -- George Carlin
%
"I turn on my television set.  I see a young lady who goes under the guise
of being a Christian, known all over the nation, dressed in skin-tight
leather pants, shaking and wiggling her hips to the beat and rythm of the
music as the strobe lights beat their patterns across the stage and the
band plays the contemporary rock sound which cannot be differentiated from
songs by the Grateful Dead, the Beatles, or anyone else.  And you may try
to tell me this is of God and that it is leading people to Christ, but I
know better.
-- Jimmy Swaggart, hypocritical sexual pervert and TV preacher, self-described
 pornography addict, "Two points of view: 'Christian' rock and roll.",
 The Evangelist, 17(8): 49-50.
%
"So-called Christian rock. . . . is a diabolical force undermining Christianity
 from within."
-- Jimmy Swaggart, hypocrite and TV preacher, self-described pornography addict,
 "Two points of view: 'Christian' rock and roll.", The Evangelist, 17(8): 49-50.
%
"Anyone attempting to generate random numbers by deterministic means is, of
course, living in a state of sin."
-- John Von Neumann
%
"You must have an IQ of at least half a million."  -- Popeye
%
"Freedom is still the most radical idea of all."
-- Nathaniel Branden
%
Aren't you glad you're not getting all the government you pay for now?
%
"I never let my schooling get in the way of my education."
-- Mark Twain
%
These screamingly hilarious gogs ensure owners of     X Ray Gogs to be the life
of any party.
-- X-Ray Gogs Instructions
%
A student asked the master for help... does this program run from the
Workbench? The master grabbed the mouse and pointed to an icon. "What is
this?" he asked. The student replied "That's the mouse". The master pressed
control-Amiga-Amiga and hit the student on the head with the Amiga ROM Kernel
Manual.
-- Amiga Zen Master Peter da Silva
%
"Thank heaven for startups; without them we'd never have any advances."
-- Seymour Cray
%
"Out of register space (ugh)"
-- vi
%
"Its failings notwithstanding, there is much to be said in favor
of journalism in that by giving us the opinion of the uneducated,
it keeps us in touch with the ignorance of the community."
                                        - Oscar Wilde
%
"Ada is PL/I trying to be Smalltalk.
-- Codoso diBlini
%
"The greatest dangers to liberty lurk in insidious encroachment by mean of zeal,
well-meaning but without understanding."
-- Justice Louis O. Brandeis (Olmstead vs. United States)
%
"'Tis true, 'tis pity, and pity 'tis 'tis true."
-- Poloniouius, in Willie the Shake's _Hamlet, Prince of Darkness_

%
"All the people are so happy now, their heads are caving in.  I'm glad they
are a snowman with protective rubber skin"
-- They Might Be Giants
%
"Indecision is the basis of flexibility"
-- button at a Science Fiction convention.
%
"Sometimes insanity is the only alternative"
-- button at a Science Fiction convention.
%
"Old age and treachery will beat youth and skill every time."
-- a coffee cup
%
"The most important thing in a man is not what he knows, but what he is."
-- Narciso Yepes
%
"All we are given is possibilities -- to make ourselves one thing or another."
-- Ortega y Gasset
%
"We will be better and braver if we engage and inquire than if we indulge in
the idle fancy that we already know -- or that it is of no use seeking to
know what we do not know."
-- Plato
%
"To undertake a project, as the word's derivation indicates, means to cast an
idea out ahead of oneself so that it gains autonomy and is fulfilled not only
by the efforts of its originator but, indeed, independently of him as well.
-- Czeslaw Milosz
%
"We cannot put off living until we are ready.  The most salient characteristic
of life is its coerciveness; it is always urgent, "here and now," without any
possible postponement.  Life is fired at us point blank."
-- Ortega y Gasset
%
"From there to here, from here to there, funny things are everywhere."
-- Dr. Seuss
%
"When it comes to humility, I'm the greatest."
-- Bullwinkle Moose

%
Remember, an int is not always 16 bits.  I'm not sure, but if the 80386 is one
step closer to Intel's slugfest with the CPU curve that is aymptotically
approaching a real machine, perhaps an int has been implemented as 32 bits by
some Unix vendors...?
-- Derek Terveer
%
"Insofar as I may be heard by anything, which may or may not care
what I say, I ask, if it matters, that you be forgiven for anything
you may have done or failed to do which requires forgiveness.
Conversely, if not forgiveness but something else may be required to
insure any possible benefit for which you may be eligible after the
destruction of your body, I ask that this, whatever it may be,
be granted or withheld, as the case may be, in such a manner as to
insure your receiving said benefit. I ask this in my capacity as
your elected intermediary between yourself and that which may not be
yourself, but which may have an interest in the matter of your
receiving as much as it is possible for you to receive of this
thing, and which may in some way be influenced by this ceremony. Amen."

Madrak, in _Creatures of Light and Darkness_, by Roger Zelazny
%
"An Academic speculated whether a bather is beautiful
if there is none in the forest to admire her. He hid
in the bushes to find out, which vitiated his premise
but made him happy.
Moral: Empiricism is more fun than speculation."
-- Sam Weber
%
1 1 was a race-horse, 2 2 was 1 2. When 1 1 1 1 race, 2 2 1 1 2.
%
"I figured there was this holocaust, right, and the only ones left alive were
 Donna Reed, Ozzie and Harriet, and the Cleavers."
-- Wil Wheaton explains why everyone in "Star Trek: The Next Generation"
    is so nice
%
"Engineering meets art in the parking lot and things explode."
-- Garry Peterson, about Survival Research Labs
%
"Why can't we ever attempt to solve a problem in this country without having
a 'War' on it?" -- Rich Thomson, talk.politics.misc
%
      ...and before I knew what I was doing, I had kicked the
      typewriter and threw it around the room and made it beg for
      mercy.  At this point the typewriter pleaded for me to dress
      him in feminine attire but instead I pressed his margin release
      over and over again until the typewriter lost consciousness.
      Presently, I regained consciousness and realized with shame what
      I had done.  My shame is gone and now I am looking for a
      submissive typewriter, any color, or model.  No electric
      typewriters please!
                        --Rick Kleiner
%
Professional wrestling:  ballet for the common man.
%
"An idealist is one who, on noticing that a rose smells better than a
cabbage, concludes that it will also make better soup." - H.L. Mencken
%
   "Are those cocktail-waitress fingernail marks?"  I asked Colletti as he
showed us these scratches on his chest.  "No, those are on my back," Colletti
answered.  "This is where a case of cocktail shrimp fell on me.  I told her
to slow down a little, but you know cocktail waitresses, they seem to have
a mind of their own."
-- The Incredibly Monstrous, Mind-Roasting Summer of O.C. and Stiggs
   National Lampoon, October 1982
%
"Never give in.  Never give in.  Never. Never. Never."
-- Winston Churchill
%
"Never ascribe to malice that which is caused by greed and ignorance."
-- Cal Keegan
%
"Despite its suffix, skepticism is not an "ism" in the sense of a belief
or dogma.  It is simply an approach to the problem of telling what is
counterfeit and what is genuine.  And a recognition of how costly it may
be to fail to do so.  To be a skeptic is to cultivate "street smarts" in
the battle for control of one's own mind, one's own money, one's own
allegiances.  To be a skeptic, in short, is to refuse to be a victim.
-- Robert S. DeBear, "An Agenda for Reason, Realism, and Responsibility,"
 New York Skeptic (newsletter of the New York Area Skeptics, Inc.), Spring 1988
%
"If you want to know what happens to you when you die, go look at some dead
stuff."
-- Dave Enyeart
%
"After one week [visiting Austria] I couldn't wait to go back to the United
States.  Everything was much more pleasant in the United States, because of
the mentality of being open-minded, always positive.  Everything you want to
do in Europe is just, 'No way.  No one has ever done it.'  They haven't any
more the desire to go out to conquer and achieve -- I realized that I had much
more the American spirit."
-- Arnold Schwarzenegger
%
"I prefer rogues to imbeciles, because they sometimes take a rest."
-- Alexandre Dumas (fils)
%
 Well, punk is kind of anti-ethical, anyway.  Its ethics, so to speak,
include a disdain for ethics in general.  If you have to think about some-
thing so hard, then it's bullshit anyway; that's the idea.  Punks are anti-
ismists, to coin a term.  But nonetheless, they have a pretty clearly defined
stance and image, and THAT is what we hang the term `punk' on.
-- Jeff G. Bone
%
 I think for the most part that the readership here uses the c-word in
a similar fashion.  I don't think anybody really believes in a new, revolution-
ary literature --- I think they use `cyberpunk' as a term of convenience to
discuss the common stylistic elements in a small subset of recent sf books.
-- Jeff G. Bone
%
 So we get to my point.  Surely people around here read things that
aren't on the *Officially Sanctioned Cyberpunk Reading List*.  Surely we
don't (any of us) really believe that there is some big, deep political and
philosophical message in all this, do we?  So if this `cyberpunk' thing is
just a term of convenience, how can somebody sell out?  If cyberpunk is just a
word we use to describe a particular style and imagery in sf, how can it be
dead?  Where are the profound statements that the `Movement' is or was trying
to make?
 I think most of us are interested in examining and discussing literary
(and musical) works that possess a certain stylistic excellence and perhaps a
rather extreme perspective; this is what CP is all about, no?  Maybe there
should be a newsgroup like, say, alt.postmodern or somthing.  Something less
restrictive in scope than alt.cyberpunk.
-- Jeff G. Bone
%
"Everyone's head is a cheap movie show."
-- Jeff G. Bone
%
Life is full of concepts that are poorly defined.  In fact, there are very few
concepts that aren't.  It's hard to think of any in non-technical fields.
-- Daniel Kimberg
%
...cyberpunk wants to see the mind as mechanistic & duplicable,
challenging basic assumptions about the nature of individuality & self.
That seems all the better reason to assume that cyberpunk art & music is
essentially mindless garbagio. Willy certainly addressed this idea in
"Count Zero," with Katatonenkunst, the automatic box-maker and the girl's
observation that the real art was the building of the machine itself,
rather than its output.
-- Eliot Handelman
%
It might be worth reflecting that this group was originally created
back in September of 1987 and has exchanged over 1200 messages.  The
original announcement for the group called for an all inclusive
discussion ranging from the writings of Gibson and Vinge and movies
like Bladerunner to real world things like Brands' description of the
work being done at the MIT Media Lab.  It was meant as a haven for
people with vision of this scope.  If you want to create a haven for
people with narrower visions, feel free.  But I feel sad for anyone
who thinks that alt.cyberpunk is such a monstrous group that it is in
dire need of being subdivided.  Heaven help them if they ever start
reading comp.arch or rec.arts.sf-lovers.
-- Bob Webber
%
...I don't care for the term 'mechanistic'. The word 'cybernetic' is a lot
more apropos. The mechanistic world-view is falling further and further behind
the real world where even simple systems can produce the most marvellous
chaos.
-- Peter da Silva
%
As for the basic assumptions about individuality and self, this is the core
of what I like about cyberpunk. And it's the core of what I like about certain
pre-gibson neophile techie SF writers that certain folks here like to put
down. Not everyone makes the same assumptions. I haven't lost my mind... it's
backed up on tape.
-- Peter da Silva
%
Who are the artists in the Computer Graphics Show?  Wavefront's latest box, or
the people who programmed it?  Should Mandelbrot get all the credit for the
output of programs like MandelVroom?
-- Peter da Silva
%
Trailing Edge Technologies is pleased to announce the following
TETflame programme:

1) For a negotiated price (no quatloos accepted) one of our flaming
   representatives will flame the living shit out of the poster of
   your choice. The price is inversly proportional to how much of
   an asshole the target it. We cannot be convinced to flame Dennis
   Ritchie. Matt Crawford flames are free.

2) For a negotiated price (same arrangement) the TETflame programme
   is offering ``flame insurence''. Under this arrangement, if
   one of our policy holders is flamed, we will cancel the offending
   article and flame the flamer, to a crisp.

3) The TETflame flaming representatives include: Richard Sexton, Oleg
   Kisalev, Diane Holt, Trish O'Tauma, Dave Hill, Greg Nowak and our most
   recent aquisition, Keith Doyle. But all he will do is put you in his
   kill file. Weemba by special arrangement.

-- Richard Sexton
%
"As I was walking among the fires of Hell, delighted with the enjoyments of
 Genius; which to Angels look like torment and insanity.  I collected some of
 their Proverbs..." - Blake, "The Marriage of Heaven and Hell"

%
   HOW TO PROVE IT, PART 1

proof by example:
 The author gives only the case n = 2 and suggests that it
 contains most of the ideas of the general proof.

proof by intimidation:
 'Trivial'.

proof by vigorous handwaving:
 Works well in a classroom or seminar setting.
%
   HOW TO PROVE IT, PART 2

proof by cumbersome notation:
 Best done with access to at least four alphabets and special
 symbols.

proof by exhaustion:
 An issue or two of a journal devoted to your proof is useful.

proof by omission:
 'The reader may easily supply the details'
 'The other 253 cases are analogous'
 '...'

%
   HOW TO PROVE IT, PART 3

proof by obfuscation:
 A long plotless sequence of true and/or meaningless
 syntactically related statements.

proof by wishful citation:
 The author cites the negation, converse, or generalization of
 a theorem from the literature to support his claims.

proof by funding:
 How could three different government agencies be wrong?

proof by eminent authority:
 'I saw Karp in the elevator and he said it was probably NP-
 complete.'

%
   HOW TO PROVE IT, PART 4

proof by personal communication:
 'Eight-dimensional colored cycle stripping is NP-complete
 [Karp, personal communication].'

proof by reduction to the wrong problem:
 'To see that infinite-dimensional colored cycle stripping is
 decidable, we reduce it to the halting problem.'

proof by reference to inaccessible literature:
 The author cites a simple corollary of a theorem to be found
 in a privately circulated memoir of the Slovenian
 Philological Society, 1883.

proof by importance:
 A large body of useful consequences all follow from the
 proposition in question.
%
   HOW TO PROVE IT, PART 5

proof by accumulated evidence:
 Long and diligent search has not revealed a counterexample.

proof by cosmology:
 The negation of the proposition is unimaginable or
 meaningless. Popular for proofs of the existence of God.

proof by mutual reference:
 In reference A, Theorem 5 is said to follow from Theorem 3 in
 reference B, which is shown to follow from Corollary 6.2 in
 reference C, which is an easy consequence of Theorem 5 in
 reference A.

proof by metaproof:
 A method is given to construct the desired proof. The
 correctness of the method is proved by any of these
 techniques.
%
   HOW TO PROVE IT, PART 6

proof by picture:
 A more convincing form of proof by example. Combines well
 with proof by omission.

proof by vehement assertion:
 It is useful to have some kind of authority relation to the
 audience.

proof by ghost reference:
 Nothing even remotely resembling the cited theorem appears in
 the reference given.

%
   HOW TO PROVE IT, PART 7
proof by forward reference:
 Reference is usually to a forthcoming paper of the author,
 which is often not as forthcoming as at first.

proof by semantic shift:
 Some of the standard but inconvenient definitions are changed
 for the statement of the result.

proof by appeal to intuition:
 Cloud-shaped drawings frequently help here.
%
        [May one] doubt whether, in cheese and timber, worms are generated,
        or, if beetles and wasps, in cow-dung, or if butterflies, locusts,
        shellfish, snails, eels, and such life be procreated of putrefied
        matter, which is to receive the form of that creature to which it
        is by formative power disposed[?]  To question this is to question
        reason, sense, and experience.  If he doubts this, let him go to
        Egypt, and there he will find the fields swarming with mice begot
        of the mud of the Nylus, to the great calamity of the inhabitants.
                A seventeenth century opinion quoted by L. L. Woodruff,
                in *The Evolution of Earth and Man*, 1929
%
Seen on a button at an SF Convention:
Veteran of the Bermuda Triangle Expeditionary Force.  1990-1951.
%
"If people are good only because they fear punishment, and hope for reward,
then we are a sorry lot indeed."
-- Albert Einstein
%
"What is wanted is not the will to believe, but the will to find out, which is
the exact opposite."
-- Bertrand Russell, _Sceptical_Essays_, 1928
%
"Were there no women, men might live like gods."
-- Thomas Dekker
%
"Intelligence without character is a dangerous thing."
-- G. Steinem
%
"It says he made us all to be just like him.  So if we're dumb, then god is
dumb, and maybe even a little ugly on the side."
-- Frank Zappa
%
"It's not just a computer -- it's your ass."
-- Cal Keegan
%
"Let me guess, Ed.  Pentescostal, right?"
-- Starcap'n Ra, ra@asuvax.asu.edu

"Nope.  Charismatic (I think - I've given up on what all those pesky labels
 mean)."
-- Ed Carp, erc@unisec.usi.com

"Same difference - all zeal and feel, averaging less than one working brain
cell per congregation. Starcap'n Ra, you pegged him.  Good work!"
-- Kenn Barry, barry@eos.UUCP
%
"BTW, does Jesus know you flame?"
-- Diane Holt, dianeh@binky.UUCP, to Ed Carp
%
"I've seen the forgeries I've sent out."
-- John F. Haugh II (jfh@rpp386.Dallas.TX.US), about forging net news articles
%
"Just out of curiosity does this actually mean something or have some
 of the few remaining bits of your brain just evaporated?"
-- Patricia O Tuama, rissa@killer.DALLAS.TX.US
%
"Bite off, dirtball."
Richard Sexton, richard@gryphon.COM
%
"Oh my!  An `inflammatory attitude' in alt.flame?  Never heard of such
a thing..."
-- Allen Gwinn, allen@sulaco.Sigma.COM
%
(null cookie; hope that's ok)
%
"In Christianity neither morality nor religion come into contact with reality
at any point."
-- Friedrich Nietzsche
%
"Who alone has reason to *lie himself out* of actuality?  He who *suffers*
 from it."
-- Friedrich Nietzsche
%
"You who hate the Jews so, why did you adopt their religion?"
-- Friedrich Nietzsche, addressing anti-semitic Christians
%
"Little prigs and three-quarter madmen may have the conceit that the laws of
nature are constantly broken for their sakes."
-- Friedrich Nietzsche
%
"Science makes godlike -- it is all over with priests and gods when man becomes
 scientific.  Moral:  science is the forbidden as such -- it alone is
 forbidden.  Science is the *first* sin, the *original* sin.  *This alone is
 morality.* ``Thou shalt not know'' -- the rest follows."
-- Friedrich Nietzsche
%
"Faith:  not *wanting* to know what is true."
-- Friedrich Nietzsche
%
>One basic notion underlying Usenet is that it is a cooperative.

Having been on USENET for going on ten years, I disagree with this.
The basic notion underlying USENET is the flame.
-- Chuq Von Rospach, chuq@Apple.COM
%
"Every group has a couple of experts.  And every group has at least one idiot.
 Thus are balance and harmony (and discord) maintained.  It's sometimes hard
 to remember this in the bulk of the flamewars that all of the hassle and
 pain is generally caused by one or two highly-motivated, caustic twits."
-- Chuq Von Rospach, chuq@apple.com, about Usenet
%
Backed up the system lately?
%
"It doesn't much signify whom one marries for one is sure to find out next
morning it was someone else."
-- Rogers
%
"If you are afraid of loneliness, don't marry."
-- Chekhov
%
"Love is an ideal thing, marriage a real thing; a confusion of the real with
the ideal never goes unpunished."
-- Goethe
%
"In matrimony, to hesitate is sometimes to be saved."
-- Butler
%
"The great question... which I have not been able to answer... is, `What does
woman want?'"
-- Sigmund Freud
%
"I have recently been examining all the known superstitions of the world,
 and do not find in our particular superstition (Christianity) one redeeming
 feature.  They are all alike founded on fables and mythology."
-- Thomas Jefferson
%
Remember:  Silly is a state of Mind, Stupid is a way of Life.
-- Dave Butler
%
"The preeminence of a learned man over a worshiper is equal to the preeminence
of the moon, at the night of the full moon, over all the stars.  Verily, the
learned men are the heirs of the Prophets."
-- A tradition attributed to Muhammad
%
"The clergy successfully preached the doctrines of patience and pusillanimity;
the active virtues of society were discouraged; and the last remains of a
military spirit were buried in the cloister: a large portion of public and
private wealth was consecrated to the specious demands of charity and devotion;
and the soldiers' pay was lavished on the useless multitudes of both sexes
who could only plead the merits of abstinence and chastity."
-- Edward Gibbons, _The Decline and Fall of the Roman Empire_
%
"The question is rather: if we ever succeed in making a mind 'of nuts and
bolts', how will we know we have succeeded?
-- Fergal Toomey

"It will tell us."
-- Barry Kort
%
"Inquiry is fatal to certainty."
-- Will Durant
%
"The Mets were great in 'sixty eight,
 The Cards were fine in 'sixty nine,
 But the Cubs will be heavenly in nineteen and seventy."
-- Ernie Banks
%
"On two occasions I have been asked [by members of Parliament!], 'Pray, Mr.
Babbage, if you put into the machine wrong figures, will the right answers
come out?'  I am not able rightly to apprehend the kind of confusion of ideas
that could provoke such a question."
-- Charles Babbage
%
"I call Christianity the *one* great curse, the *one* great intrinsic
depravity, the *one* great instinct for revenge for which no expedient
is sufficiently poisonous, secret, subterranean, *petty* -- I call it
the *one* mortal blemish of mankind."
-- Friedrich Nietzsche
%
"The fundamental purpose animating the Faith of God and His Religion is to
safeguard the interests and promote the unity of the human race, and to foster
the spirit of love and fellowship amongst men. Suffer it not to become a source
of dissension and discord, of hate and enmity."

"Religion is verily the chief instrument for the establishment of order in the
 world and of tranquillity amongst it's peoples...The greater the decline of
 religion, the more grievous the waywardness of the ungodly. This cannot but
 lead in the end to chaos and confusion."
-- Baha'u'llah, a selection from the Baha'i scripture
%
"Cogito ergo I'm right and you're wrong."
-- Blair Houghton
%
"...one of the main causes of the fall of the Roman Empire was that,
lacking zero, they had no way to indicate successful termination of
their C programs."
-- Robert Firth
%
Q: Somebody just posted that Roman Polanski directed Star Wars.  What
should I do?

A: Post the correct answer at once!  We can't have people go on believing
that!  Very good of you to spot this.  You'll probably be the only one to
make the correction, so post as soon as you can.  No time to lose, so
certainly don't wait a day, or check to see if somebody else has made the
correction.

And it's not good enough to send the message by mail.  Since you're the
only one who really knows that it was Francis Coppola, you have to inform
the whole net right away!

-- Brad Templeton, _Emily Postnews Answers Your Questions on Netiquette_
%
Q: How can I choose what groups to post in?  ...
Q: How about an example?

A: Ok.  Let's say you want to report that Gretzky has been traded from the
Oilers to the Kings.  Now right away you might think rec.sport.hockey
would be enough.  WRONG.  Many more people might be interested.  This is a
big trade!  Since it's a NEWS article, it belongs in the news.* hierarchy
as well.  If you are a news admin, or there is one on your machine, try
news.admin.  If not, use news.misc.

The Oilers are probably interested in geology, so try sci.physics.  He is
a big star, so post to sci.astro, and sci.space because they are also
interested in stars.  Next, his name is Polish sounding.  So post to
soc.culture.polish.  But that group doesn't exist, so cross-post to
news.groups suggesting it should be created.  With this many groups of
interest, your article will be quite bizarre, so post to talk.bizarre as
well.  (And post to comp.std.mumps, since they hardly get any articles
there, and a "comp" group will propagate your article further.)

You may also find it is more fun to post the article once in each group.
If you list all the newsgroups in the same article, some newsreaders will
only show the the article to the reader once!  Don't tolerate this.
-- Brad Templeton, _Emily Postnews Answers Your Questions on Netiquette_
%
Q: I cant spell worth a dam.  I hope your going too tell me what to do?

A: Don't worry about how your articles look.  Remember it's the message
that counts, not the way it's presented.  Ignore the fact that sloppy
spelling in a purely written forum sends out the same silent messages that
soiled clothing would when addressing an audience.

-- Brad Templeton, _Emily Postnews Answers Your Questions on Netiquette_
%
Q: They just announced on the radio that Dan Quayle was picked as the
Republican V.P. candidate.  Should I post?

A: Of course.  The net can reach people in as few as 3 to 5 days.  It's
the perfect way to inform people about such news events long after the
broadcast networks have covered them.  As you are probably the only person
to have heard the news on the radio, be sure to post as soon as you can.

-- Brad Templeton, _Emily Postnews Answers Your Questions on Netiquette_
%
What did Mickey Mouse get for Christmas?

A Dan Quayle watch.

-- heard from a Mike Dukakis field worker
%
Q:  What's the difference between a car salesman and a computer
    salesman?

A:  The car salesman can probably drive!

-- Joan McGalliard (jem@latcs1.oz.au)
%
"Your stupidity, Allen, is simply not up to par."
-- Dave Mack (mack@inco.UUCP)

"Yours is."
-- Allen Gwinn (allen@sulaco.sigma.com), in alt.flame
%
A selection from the Taoist Writings:

"Lao-Tan asked Confucius: `What do you mean by benevolence and righteousness?'
 Confucius said:  `To be in one's inmost heart in kindly sympathy with all
 things; to love all men and allow no selfish thoughts: this is the nature
 of benevolence and righteousness.'"
-- Kwang-tzu
%
"Jesus saves...but Gretzky gets the rebound!"
-- Daniel Hinojosa (hinojosa@hp-sdd)
%
"Anything created must necessarily be inferior to the essence of the creator."
-- Claude Shouse (shouse@macomw.ARPA)

"Einstein's mother must have been one heck of a physicist."
-- Joseph C. Wang (joe@athena.mit.edu)
%
"Religion is something left over from the infancy of our intelligence, it will
fade away as we adopt reason and science as our guidelines."
-- Bertrand Russell
%
"Lying lips are abomination to the Lord; but they that deal truly are his
 delight.
 A soft answer turneth away wrath; but grievous words stir up anger.
 He that answereth a matter before he heareth it, it is folly and shame unto
 him.
 Be not a witness against thy neighbor without cause; and deceive not with
 thy lips.
 Death and life are in the power of the tongue."
-- Proverbs, some selections from the Jewish Scripture
%
"As an adolescent I aspired to lasting fame, I craved factual certainty, and
I thirsted for a meaningful vision of human life -- so I became a scientist.
This is like becoming an archbishop so you can meet girls."
-- Matt Cartmill
%
Heisenberg might have been here.
%
"Any excuse will serve a tyrant."
-- Aesop
%
"Experience has proved that some people indeed know everything."
-- Russell Baker
%
How many Zen Buddhist does it take to change a light bulb?

Two.  One to change it and one not to change it.
%
"I prefer the blunted cudgels of the followers of the Serpent God."
-- Sean Doran the Younger
%
"If I do not want others to quote me, I do not speak."
-- Phil Wayne
%
"my terminal is a lethal teaspoon."
-- Patricia O Tuama
%
"I am ... a woman ... and ... technically a parasitic uterine growth"
-- Sean Doran the Younger [allegedly]
%
"Is it just me, or does anyone else read `bible humpers' every time
someone writes `bible thumpers?'
-- Joel M. Snyder, jms@mis.arizona.edu
%
"Money is the root of all money."
-- the moving finger
%
"...Greg Nowak:  `Another flame from greg' - need I say more?"
-- Jonathan D. Trudel, trudel@caip.rutgers.edu

"No.  You need to say less."
-- Richard Sexton, richard@gryphon.COM
%
"And it's my opinion, and that's only my opinion, you are a lunatic.  Just
because there are a few hunderd other people sharing your lunacy with you
does not make you any saner.  Doomed, eh?"
-- Oleg Kiselev,oleg@CS.UCLA.EDU
%
"Obedience.  A religion of slaves.  A religion of intellectual death.  I like
it.  Don't ask questions, don't think, obey the Word of the Lord -- as it
has been conveniently brought to you by a man in a Rolls with a heavy Rolex
on his wrist.  I like that job!  Where can I sign up?"
-- Oleg Kiselev,oleg@CS.UCLA.EDU
%
"Home life as we understand it is no more natural to us than a cage is to a
cockatoo."
-- George Bernard Shaw
%
"Marriage is like a cage; one sees the birds outside desperate to get in, and
those inside desperate to get out."
-- Montaigne
%
"For a male and female to live continuously together is...  biologically
speaking, an extremely unnatural condition."
-- Robert Briffault
%
"Marriage is low down, but you spend the rest of your life paying for it."
-- Baskins
%
A man is not complete until he is married -- then he is finished.
%
Marriage is the sole cause of divorce.
%
Marriage is the triumph of imagination over intelligence.  Second marriage is
the triumph of hope over experience.
%
"The chain which can be yanked is not the eternal chain."
-- G. Fitch
%
"Go to Heaven for the climate, Hell for the company."
-- Mark Twain
%
"I am convinced that the manufacturers of carpet odor removing powder have
 included encapsulated time released cat urine in their products.  This
 technology must be what prevented its distribution during my mom's reign.  My
 carpet smells like piss, and I don't have a cat.  Better go by some more."
-- timw@zeb.USWest.COM, in alt.conspiracy
%
"If there isn't a population problem, why is the government putting cancer in
the cigarettes?"
-- the elder Steptoe, c. 1970
%
"If you don't want your dog to have bad breath, do what I do:  Pour a little
 Lavoris in the toilet."
-- Comedian Jay Leno
%
"Here's something to think about:  How come you never see a headline like
 `Psychic Wins Lottery.'"
-- Comedian Jay Leno
%
"Well hello there Charlie Brown, you blockhead."
-- Lucy Van Pelt
%
"Time is an illusion.  Lunchtime doubly so."
-- Ford Prefect, _Hitchhiker's Guide to the Galaxy_
%
"Ignorance is the soil in which belief in miracles grows."
-- Robert G. Ingersoll
%
"Let every man teach his son, teach his daughter, that labor is honorable."
-- Robert G. Ingersoll
%
"I have not the slightest confidence in 'spiritual manifestations.'"
-- Robert G. Ingersoll
%
"It is hard to overstate the debt that we owe to men and women of genius."
-- Robert G. Ingersoll
%
"Joy is wealth and love is the legal tender of the soul."
-- Robert G. Ingersoll
%
"The hands that help are better far than the lips that pray."
-- Robert G. Ingersoll
%
"It is the creationists who blasphemously are claiming that God is cheating
 us in a stupid way."
-- J. W. Nienhuys
%
"No, no, I don't mind being called the smartest man in the world.  I just wish
 it wasn't this one."
-- Adrian Veidt/Ozymandias, WATCHMEN
%
"Be *excellent* to each other."
-- Bill, or Ted, in Bill and Ted's Excellent Adventure
%
The Seventh Edition licensing procedures are, I suppose, still in effect,
though I doubt that tapes are available from AT&T.  At any rate, whatever
restrictions the license imposes still exist.  These restrictions were and
are reasonable for places that just want to run the system, but don't allow
many of the things that Minix was written for, like study of the source in
classes, or by individuals not in a university or company.

I've always thought that Minix was a fine idea, and competently done.

As for the size of v7, wc -l /usr/sys/*/*.[chs] is 19271.

-- Dennis Ritchie, 1989
%
"Our vision is to speed up time, eventually eliminating it." -- Alex Schure
%
"Love is a snowmobile racing across the tundra and then suddenly it flips
 over, pinning you underneath.  At night, the ice weasels come."
--Matt Groening
%
"I'm not afraid of dying, I just don't want to be there when it happens."
-- Woody Allen
%
"The Street finds its own uses for technology."
-- William Gibson
%
"I see little divinity about them or you.  You talk to me of Christianity
when you are in the act of hanging your enemies.  Was there ever such
blasphemous nonsense!"
-- Shaw, "The Devil's Disciple"
%
"You and I as individuals can, by borrowing, live beyond our means, but
only for a limited period of time.  Why should we think that collectively,
as a nation, we are not bound by that same limitation?"
-- Ronald Reagan
%
"He did decide, though, that with more time and a great deal of mental effort,
he could probably turn the activity into an acceptable perversion."
-- Mick Farren, _When Gravity Fails_
%
"Conversion, fastidious Goddess, loves blood better than brick, and feasts
most subtly on the human will."
-- Virginia Woolf, "Mrs. Dalloway"
%
It's time to boot, do your boot ROMs know where your disk controllers are?
%
"What the scientists have in their briefcases is terrifying."
-- Nikita Khrushchev
%
"...a most excellent barbarian ... Genghis Kahn!"
-- _Bill And Ted's Excellent Adventure_
%
"Pull the trigger and you're garbage."
-- Lady Blue
%
"Oh what wouldn't I give to be spat at in the face..."
-- a prisoner in "Life of Brian"
%
"Truth never comes into the world but like a bastard, to the ignominy
of him that brought her birth."
-- Milton
%
"If you can't debate me, then there is no way in hell you'll out-insult me."
-- Scott Legrand (Scott.Legrand@hogbbs.Fidonet.Org)

"You may be wrong here, little one."
-- R. W. F. Clark (RWC102@PSUVM)
%
 "Yes, I am a real piece of work.  One thing we learn at Ulowell is
 how to flame useless hacking non-EE's like you.  I am superior to you in
 every way by training and expertise in the technical field.  Anyone can learn
 how to hack, but Engineering doesn't come nearly as easily.  Actually, I'm
 not trying to offend all you CS majors out there, but I think EE is one of the
 hardest majors/grad majors to pass.  Fortunately, I am making it."
-- "Warrior Diagnostics" (wardiag@sky.COM)

"Being both an EE and an asshole at the same time must be a terrible burden
 for you.  This isn't really a flame, just a casual observation.  Makes me
 glad I was a CS major, life is really pleasant for me.  Have fun with your
 chosen mode of existence!"
-- Jim Morrison (morrisj@mist.cs.orst.edu)
%
"BYTE editors are men who seperate the wheat from the chaff, and then
 print the chaff."
-- Lionel Hummel (uiucdcs!hummel), derived from a quote by Adlai Stevenson, Sr.
%
       THE "FUN WITH USENET" MANIFESTO
Very little happens on Usenet without some sort of response from some other
reader.  Fun With Usenet postings are no exception.  Since there are some who
might question the rationale of some of the excerpts included therein, I have
written up a list of guidelines that sum up the philosophy behind these
postings.

 One.  I never cut out words in the middle of a quote without a VERY
good reason, and I never cut them out without including ellipses.  For
instance, "I am not a goob" might become "I am ... a goob", but that's too
mundane to bother with.  "I'm flame proof" might (and has) become
"I'm ...a... p...oof" but that's REALLY stretching it.

 Two.  If I cut words off the beginning or end of a quote, I don't
put ellipses, but neither do I capitalize something that wasn't capitalized
before the cut. "I don't think that the Church of Ubizmo is a wonderful
place" would turn into "the Church of Ubizmo is a wonderful place".  Imagine
the posting as a tape-recording of the poster's thoughts.  If I can set
up the quote via fast-forwarding and stopping the tape, and without splicing,
I don't put ellipses in.  And by the way, I love using this mechanism for
turning things around.  If you think something stinks, say so - don't say you
don't think it's wonderful.   ...
-- D. J. McCarthy (dmccart@cadape.UUCP)
%
"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
-- Benjamin Franklin, 1759
%
"I am, therefore I am."
-- Akira
%
"Stan and I thought that this experiment was so stupid, we decided to finance
 it ourselves."
-- Martin Fleischmann, co-discoverer of room-temperature fusion (?)
%
"I have more information in one place than anybody in the world."
-- Jerry Pournelle, an absurd notion, apparently about the BIX BBS
%
"It's what you learn after you know it all that counts."
-- John Wooden
%
#define BITCOUNT(x) (((BX_(x)+(BX_(x)>>4)) & 0x0F0F0F0F) % 255)
#define  BX_(x)  ((x) - (((x)>>1)&0x77777777)   \
        - (((x)>>2)&0x33333333)   \
        - (((x)>>3)&0x11111111))

-- really weird C code to count the number of bits in a word
%
"If you can write a nation's stories, you needn't worry about who makes its
 laws.  Today, television tells most of the stories to most of the people
 most of the time."
-- George Gerbner
%
"The reasonable man adapts himself to the world; the unreasonable one persists
 in trying to adapt the world to himself.  Therefore all progress depends on
 the unreasonable man."
-- George Bernard Shaw
%
"We want to create puppets that pull their own strings."
-- Ann Marion

"Would this make them Marionettes?"
-- Jeff Daiell
%
On the subject of C program indentation:
"In My Egotistical Opinion, most people's C programs should be indented
 six feet downward and covered with dirt."
-- Blair P. Houghton
%
There was, it appeared, a mysterious rite of initiation through which, in
one way or another, almost every member of the team passed.  The term that
the old hands used for this rite -- West invented the term, not the practice --
was `signing up.'  By signing up for the project you agreed to do whatever
was necessary for success.  You agreed to forsake, if necessary, family,
hobbies, and friends -- if you had any of these left (and you might not, if
you had signed up too many times before).
-- Tracy Kidder, _The Soul of a New Machine_
%
"By the time they had diminished from 50 to 8, the other dwarves began
to suspect "Hungry."
-- a Larson cartoon
%
"But don't you see, the color of wine in a crystal glass can be spiritual.
 The look in a face, the music of a violin.  A Paris theater can be infused
 with the spiritual for all its solidity."
 -- Lestat, _The Vampire Lestat_, Anne Rice
%
"Love your country but never trust its government."
-- from a hand-painted road sign in central Pennsylvania
%
      I bought the latest computer;
      it came fully loaded.
      It was guaranteed for 90 days,
      but in 30 was outmoded!
        - The Wall Street Journal passed along by Big Red Computer's SCARLETT
%
To update Voltaire, "I may kill all msgs from you, but I'll fight for
your right to post it, and I'll let it reside on my disks".
-- Doug Thompson (doug@isishq.FIDONET.ORG)
%
"Though a program be but three lines long,
someday it will have to be maintained."
-- The Tao of Programming
%
"Turn on, tune up, rock out."
-- Billy Gibbons
%
         EARTH
     smog  |   bricks
 AIR  --  mud  --  FIRE
soda water |   tequila
         WATER
%
"Of course power tools and alcohol don't mix.  Everyone knows power tools aren't
soluble in alcohol..."
-- Crazy Nigel
%
"Life sucks, but death doesn't put out at all...."
-- Thomas J. Kopp
%
   n = ((n >>  1) & 0x55555555) | ((n <<  1) & 0xaaaaaaaa);
   n = ((n >>  2) & 0x33333333) | ((n <<  2) & 0xcccccccc);
   n = ((n >>  4) & 0x0f0f0f0f) | ((n <<  4) & 0xf0f0f0f0);
   n = ((n >>  8) & 0x00ff00ff) | ((n <<  8) & 0xff00ff00);
   n = ((n >> 16) & 0x0000ffff) | ((n << 16) & 0xffff0000);

-- Yet another mystical 'C' gem. This one reverses the bits in a word.
%
"All over the place, from the popular culture to the propaganda system, there is
constant pressure to make people feel that they are helpless, that the only role
they can have is to ratify decisions and to consume."
-- Noam Chomsky
%
"A complex system that works is invariably found to have evolved from a simple
system that worked."
-- John Gall, _Systemantics_
%
"In my opinion, Richard Stallman wouldn't recognise terrorism if it
came up and bit him on his Internet."
-- Ross M. Greenberg
%
I made it a rule to forbear all direct contradictions to the sentiments of
others, and all positive assertion of my own.  I even forbade myself the use
of every word or expression in the language that imported a fixed opinion,
such as "certainly", "undoubtedly", etc.   I adopted instead of them "I
conceive", "I apprehend", or "I imagine" a thing to be so or so; or "so it
appears to me at present".

When another asserted something that I thought an error, I denied myself the
pleasure of contradicting him abruptly, and of showing him immediately some
absurdity in his proposition.  In answering I began by observing that in
certain cases or circumstances his opinion would be right, but in the present
case there appeared or semed to me some difference, etc.

I soon found the advantage of this change in my manner; the conversations I
engaged in went on more pleasantly.  The modest way in which I proposed my
opinions procured them a readier reception and less contradiction.  I had
less mortification when I was found to be in the wrong, and I more easily
prevailed with others to give up their mistakes and join with me when I
happened to be in the right.
-- Autobiography of Benjamin Franklin
%
"If I ever get around to writing that language depompisifier, it will change
almost all occurences of the word "paradigm" into "example" or "model."
-- Herbie Blashtfalt
%
"Life, loathe it or ignore it, you can't like it."
-- Marvin the paranoid android
%
Contemptuous lights flashed across the computer's console.
-- Hitchhiker's Guide to the Galaxy
%
"There must be some mistake," he said, "are you not a greater computer than
the Milliard Gargantubrain which can count all the atoms in a star in a
millisecond?"
"The Milliard Gargantubrain?" said Deep Thought with unconcealed contempt.
"A mere abacus.  Mention it not."
-- Hitchhiker's Guide to the Galaxy
%
"But are you not," he said, "a more fiendish disputant than the Great Hyperlobic
Omni-Cognate Neutron Wrangler of Ciceronicus Twelve, the Magic and
Indefatigable?"

"The Great Hyperlobic Omni-Cognate Neutron Wrangler," said Deep Thought,
thoroughly rolling the r's, "could talk all four legs off an Arcturan
Mega-Donkey -- but only I could persuade it to go for a walk afterward."
-- Hitchhiker's Guide to the Galaxy
%
If builders built buildings the way programmers write programs, Jolt Cola
would be a Fortune-500 company.

If builders built buildings the way programmers write programs, you'd be
able to buy a nice little colonial split-level at Babbages for $34.95.

If programmers wrote programs the way builders build buildings, we'd still
be using autocoder and running compile decks.

-- Peter da Silva and Karl Lehenbauer, a different perspective
%
To err is human, to moo bovine.
%
"America is a stronger nation for the ACLU's uncompromising effort."
-- President John F. Kennedy
%
"The simple rights, the civil liberties from generations of struggle must not
be just fine words for patriotic holidays, words we subvert on weekdays, but
living, honored rules of conduct amongst us...I'm glad the American Civil
Liberties Union gets indignant, and I hope this will always be so."
-- Senator Adlai E. Stevenson
%
"The ACLU has stood foursquare against the recurring tides of hysteria that
>from time to time threaten freedoms everyhere... Indeed, it is difficult
to appreciate how far our freedoms might have eroded had it not been for the
Union's valiant representation in the courts of the constitutional rights
of people of all persuasions, no matter how unpopular or even despised
by the majority they were at the time."
-- former Supreme Court Chief Justice Earl Warren
%
"The strength of the Constitution lies entirely in the determination of each
citizen to defend it.  Only if every single citizen feels duty bound to do
his share in this defense are the constitutional rights secure."
-- Albert Einstein
%
"Well I don't see why I have to make one man miserable when I can make so many
men happy."
-- Ellyn Mustard, about marriage
%
"And it should be the law: If you use the word `paradigm' without knowing what
the dictionary says it means, you go to jail. No exceptions."
-- David Jones @ Megatest Corporation
%
"Luke, I'm yer father, eh.  Come over to the dark side, you hoser."
-- Dave Thomas, "Strange Brew"
%
"Let's not be too tough on our own ignorance.  It's the thing that makes
 America great.  If America weren't incomparably ignorant, how could we
 have tolerated the last eight years?"
-- Frank Zappa, Feb 1, 1989
%
"The History of every major Galactic Civilization tends to pass through
three distinct and recognizable phases, those of Survival, Inquiry and
Sophistication, otherwise known as the How, Why and Where phases.
"For instance, the first phase is characterized by the question 'How can
we eat?' the second by the question 'Why do we eat?' and the third by
the question 'Where shall we have lunch?'"
-- Hitchhiker's Guide to the Galaxy
%
"Don't think; let the machine do it for you!"
-- E. C. Berkeley
%
"It follows that any commander in chief who undertakes to carry out a plan
 which he considers defective is at fault; he must put forth his reasons,
 insist of the plan being changed, and finally tender his resignation rather
than be the instrument of his army's downfall."
-- Napoleon, "Military Maxims and Thought"
%
"(The Chief Programmer) personally defines the functional and performance
 specifications, designs the program, codes it, tests it, and writes its
 documentation... He needs great talent, ten years experience and
 considerable systems and applications knowledge, whether in applied
 mathematics, business data handling, or whatever."
-- Fred P. Brooks, _The Mythical Man Month_
%
"It ain't over until it's over."
-- Casey Stengel
%
"If anything can go wrong, it will."
-- Edsel Murphy
%
"Yo baby yo baby yo."
-- Eddie Murphy
%
"You must learn to run your kayak by a sort of ju-jitsu.  You must learn to
 tell what the river will do to you, and given those parameters see how you
 can live with it.  You must absorb its force and convert it to your users
 as best you can.  Even with the quickness and agility of a kayak, you are
 not faster than the river, nor stronger, and you can beat it only by
 understanding it."
-- Strung, Curtis and Perry, _Whitewater_
%
Everyone who comes in here wants three things:
 1. They want it quick.
 2. They want it good.
 3. They want it cheap.
I tell 'em to pick two and call me back.
-- sign on the back wall of a small printing company in Delaware
%
"More software projects have gone awry for lack of calendar time than for all
 other causes combined."
-- Fred Brooks, Jr., _The Mythical Man Month_
%
panic: kernel trap (ignored)
%
"Nuclear war can ruin your whole compile."
-- Karl Lehenbauer
%
"Remember, extremism in the nondefense of moderation is not a virtue."
-- Peter Neumann, about usenet
%
"We dedicated ourselves to a powerful idea -- organic law rather than naked
 power.  There seems to be universal acceptance of that idea in the nation."
-- Supreme Court Justice Potter Steart
%
"What man has done, man can aspire to do."
-- Jerry Pournelle, about space flight
%
"Well, it don't make the sun shine, but at least it don't deepen the shit."
-- Straiter Empy, in _Riddley_Walker_ by Russell Hoban
%
"If you can, help others.  If you can't, at least don't hurt others."
-- the Dalai Lama
%
To the systems programmer, users and applications serve only to provide a
test load.
%
"Just think, with VLSI we can have 100 ENIACS on a chip!"
-- Alan Perlis
%
"...Local prohibitions cannot block advances in military and commercial
 technology... Democratic movements for local restraint can only restrain
 the world's democracies, not the world as a whole."
-- K. Eric Drexler
%
"The rotter who simpers that he sees no difference between a five-dollar bill
and a whip deserves to learn the difference on his own back -- as, I think, he
will."
-- Francisco d'Anconia, in Ayn Rand's _Atlas Shrugged_
%
"If a nation values anything more than freedom, it will lose its freedom; and
 the irony of it is that if it is comfort or money it values more, it will
 lose that, too."
-- W. Somerset Maugham
%
"Pardon me for breathing, which I never do anyway so I don't know why I bother
 to say it, oh God, I'm so depressed.  Here's another of those self-satisfied
 doors.  Life!  Don't talk to me about life."
-- Marvin the Paranoid Android
%
One of the major difficulties Trillian experienced in her relationship with
Zaphod was learning to distinguish between him pretending to be stupid just
to get people off their guard, pretending to be stupid because he couldn't
be bothered to think and wanted someone else to do it for him, pretending
to be so outrageously stupid to hide the fact that he actually didn't understand
hat was going on, and really being genuinely stupid.  He was reknowned for
being quite clever and quite clearly was so -- but not all the time, which
obviously worried him, hence the act.  He preferred people to be puzzled
rather than contemptuous.  This above all appeared to Trillian to be
genuinely stupid, but she could no longer be bothered to argue about.
-- Douglas Adams, _The Hitchhiker's Guide to the Galaxy_
%
Far back in the mists of ancient time, in the great and glorious days of the
former Galactic Empire, life was wild, rich and largely tax free.

Mighty starships plied their way between exotic suns, seeking adventure and
reward among the furthest reaches of Galactic space.  In those days, spirits
were brave, the stakes were high, men were real men, women were real women
and small furry creatures from Alpha Centauri were real small furry creatures
from Alpha Centauri.  And all dared to brave unknown terrors, to do mighty
deeds, to boldly split infinitives that no man had split before -- and thus
was the Empire forged.
-- Douglas Adams, _The Hitchhiker's Guide to the Galaxy_
%
"Gort, klaatu nikto barada."
-- The Day the Earth Stood Still
%
> From MAILER-DAEMON@Think.COM Thu Mar  2 13:59:11 1989
> Subject: Returned mail: unknown mailer error 255

"Dale, your address no longer functions.  Can you fix it at your end?"
-- Bill Wolfe (wtwolfe@hubcap.clemson.edu)

"Bill, Your brain no longer functions.  Can you fix it at your end?"
-- Karl A. Nyberg (nyberg@ajpo.sei.cmu.edu)
%
"Don't drop acid, take it pass-fail!"
-- Bryan Michael Wendt
%
"I got a question for ya.  Ya got a minute?"
-- two programmers passing in the hall
%
I took a fish head to the movies and I didn't have to pay.
-- Fish Heads, Saturday Night Live, 1977.
%
What hath Bob wrought?
%
"I don't know where we come from,
 Don't know where we're going to,
 And if all this should have a reason,
 We would be the last to know.

 So let's just hope there is a promised land,
 And until then,
 ...as best as you can."
-- Steppenwolf, "Rock Me Baby"
%
"Help Mr. Wizard!"
-- Tennessee Tuxedo
%
"The lawgiver, of all beings, most owes the law allegiance.
 He of all men should behave as though the law compelled him.
 But it is the universal weakness of mankind that what we are
 given to administer we presently imagine we own."
-- H.G. Wells
%
"Unlike most net.puritans, however, I feel that what OTHER consenting computers
 do in the privacy of their own phone connections is their own business."
-- John Woods, jfw@eddie.mit.edu
%
"Don't talk to me about disclaimers!  I invented disclaimers!"
-- The Censored Hacker
%
'On this point we want to be perfectly clear: socialism has nothing to do
with equalizing.  Socialism cannot ensure conditions of life and
consumption in accordance with the principle "From each according to his
ability, to each according to his needs."  This will be under communism.
Socialism has a different criterion for distributing social benefits:
"From each according to his ability, to each according to his work."'
-- Mikhail Gorbachev, _Perestroika_
%
"Cable is not a luxury, since many areas have poor TV reception."
-- The mayor of Tucson, Arizona, 1989
[apparently, good TV reception is a basic necessity -- at least in Tucson  -kl]
%
"All the system's paths must be topologically and circularly interrelated for
 conceptually definitive, locally transformable, polyhedronal understanding to
 be attained in our spontaneous -- ergo, most economical -- geodesiccally
 structured thoughts."
-- R. Buckminster Fuller [...and a total nonsequitur as far as I can tell.  -kl]
%
"One thing they don't tell you about doing experimental physics is that
 sometimes you must work under adverse conditions... like a state of sheer
 terror."
-- W. K. Hartmann
%
"It's when they say 2 + 2 = 5 that I begin to argue."
-- Eric Pepke
%
Comparing information and knowledge is like asking whether the fatness of a
pig is more or less green than the designated hitter rule."
-- David Guaspari
%
"None of our men are "experts."  We have most unfortunately found it necessary
to get rid of a man as soon as he thinks himself an expert -- because no one
ever considers himself expert if he really knows his job.  A man who knows a
job sees so much more to be done than he has done, that he is always pressing
forward and never gives up an instant of thought to how good and how efficient
he is.  Thinking always ahead, thinking always of trying to do more, brings a
state of mind in which nothing is impossible. The moment one gets into the
"expert" state of mind a great number of things become impossible."
-- From Henry Ford Sr., "My Life and Work," p. 86 (1922):
%
"The NY Times is read by the people who run the country.  The Washington Post
is read by the people who think they run the country.   The National Enquirer
is read by the people who think Elvis is alive and running the country..."
-- Robert J Woodhead (trebor@biar.UUCP)
%
        "...'fire' does not matter, 'earth' and 'air' and 'water' do not
matter.  'I' do not matter.  No word matters.  But man forgets reality
and remembers words.  The more words he remembers, the cleverer do his
fellows esteem him.  He looks upon the great transformations of the
world, but he does not see them as they were seen when man looked upon
reality for the first time.  Their names come to his lips and he smiles
as he tastes them, thinking he knows them in the naming."
-- Siddartha, _Lord_of_Light_ by Roger Zelazny
%
"Irrigation of the land with sewater desalinated by fusion power is ancient.
It's called 'rain'."
-- Michael McClary, in alt.fusion
%
"The bad reputation UNIX has gotten is totally undeserved, laid on by people
 who don't understand, who have not gotten in there and tried anything."
-- Jim Joyce, former computer science lecturer at the University of California
%
"We scientists, whose tragic destiny it has been to make the methods of
annihilation ever more gruesome and more effective, must consider it our solemn
and transcendent duty to do all in our power in preventing these weapons from
being used for the brutal purpose for which they were invented."
-- Albert Einstein, Bulletin of Atomic Scientists, September 1948
%
"You can have my Unix system when you pry it from my cold, dead fingers."
-- Cal Keegan
%
We'll be more than happy to do so once Jim shows the slightest sign
of interest in fixing his proposal to deal with the technical
arguments that have *already* been made.  Most engineers have
learned there is little to be gained in fine-tuning the valve timing
on a gasoline-powered internal combustion engine when the pistons
and crankshaft are missing...
  -- Valdis.Kletnieks@vt.edu on NANOG
%
17th Rule of Friendship:
 A friend will refrain from telling you he picked up the same amount of
 life insurance coverage you did for half the price when yours is
 noncancellable.
  -- Esquire, May 1977
%
186,282 miles per second:
 It isn't just a good idea, it's the law!
%
18th Rule of Friendship:
        A friend will let you hold the ladder while he goes up on the roof
        to install your new aerial, which is the biggest son-of-a-bitch you
        ever saw.
                -- Esquire, May 1977
%
2180, U.S. History question:
 What 20th Century U.S. President was almost impeached and what
 office did he later hold?
%
3rd Law of Computing:
 Anything that can go wr
fortune: Segmentation violation -- Core dumped
%
667:
 The neighbor of the beast.
%
A hypothetical paradox:
 What would happen in a battle between an Enterprise security team,
 who always get killed soon after appearing, and a squad of Imperial
 Stormtroopers, who can't hit the broad side of a planet?
  -- Tom Galloway
%
A Law of Computer Programming:
 Make it possible for programmers to write in English
 and you will find that programmers cannot write in English.
%
A musician, an artist, an architect:
 the man or woman who is not one of these is not a Christian.
  -- William Blake
%
A new koan:
 If you have some ice cream, I will give it to you.
 If you have no ice cream, I will take it away from you.
It is an ice cream koan.
%
Abbott's Admonitions:
 (1) If you have to ask, you're not entitled to know.
 (2) If you don't like the answer, you shouldn't have asked the question.
  -- Charles Abbot, dean, University of Virginia
%
Absent, adj.:
 Exposed to the attacks of friends and acquaintances; defamed; slandered.
%
Absentee, n.:
 A person with an income who has had the forethought to remove
 himself from the sphere of exaction.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Abstainer, n.:
 A weak person who yields to the temptation of denying himself a
 pleasure.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Absurdity, n.:
 A statement or belief manifestly inconsistent with one's own opinion.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Academy:
 A modern school where football is taught.
Institute:
 An archaic school where football is not taught.
%
Acceptance testing:
 An unsuccessful attempt to find bugs.
%
Accident, n.:
 A condition in which presence of mind is good, but absence of
 body is better.
  -- Foolish Dictionary
%
Accordion, n.:
 A bagpipe with pleats.
%
Accuracy, n.:
 The vice of being right
%
Acquaintance, n:
 A person whom we know well enough to borrow from but not well
 enough to lend to.  A degree of friendship called slight when the
 object is poor or obscure, and intimate when he is rich or famous.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
ADA:
 Something you need only know the name of to be an Expert in
 Computing.  Useful in sentences like, "We had better develop
 an ADA awareness.
  -- "Datamation", January 15, 1984
%
Adler's Distinction:
 Language is all that separates us from the lower animals,
 and from the bureaucrats.
%
Admiration, n.:
 Our polite recognition of another's resemblance to ourselves.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Adore, v.:
 To venerate expectantly.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Adult, n.:
 One old enough to know better.
%
Advertising Rule:
 In writing a patent-medicine advertisement, first convince the
 reader that he has the disease he is reading about; secondly,
 that it is curable.
%
Afternoon, n.:
 That part of the day we spend worrying about how we wasted the morning.
%
Age, n.:
 That period of life in which we compound for the vices that we
 still cherish by reviling those that we no longer have the enterprise
 to commit.
  -- Ambrose Bierce
%
Agnes' Law:
 Almost everything in life is easier to get into than out of.
%
Air Force Inertia Axiom:
 Consistency is always easier to defend than correctness.
%
air, n.:
 A nutritious substance supplied by a bountiful Providence for the
 fattening of the poor.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Alaska:
 A prelude to "No."
%
Albrecht's Law:
 Social innovations tend to the level of minimum tolerable well-being.
%
Alden's Laws:
 (1)  Giving away baby clothes and furniture is the major cause
      of pregnancy.
 (2)  Always be backlit.
 (3)  Sit down whenever possible.
%
algorithm, n.:
 Trendy dance for hip programmers.
%
alimony, n:
 Having an ex you can bank on.
%
All new:
 Parts not interchangeable with previous model.
%
Allen's Axiom:
 When all else fails, read the instructions.
%
Alliance, n.:
 In international politics, the union of two thieves who have
 their hands so deeply inserted in each other's pocket that they cannot
 separately plunder a third.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Alone, adj.:
 In bad company.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Ambidextrous, adj.:
 Able to pick with equal skill a right-hand pocket or a left.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Ambiguity:
 Telling the truth when you don't mean to.
%
Ambition, n:
 An overmastering desire to be vilified by enemies while
 living and made ridiculous by friends when dead.
  -- Ambrose Bierce
%
Amoebit:
 Amoeba/rabbit cross; it can multiply and divide at the same time.
%
Andrea's Admonition:
 Never bestow profanity upon a driver who has wronged you.
 If you think his window is closed and he can't hear you,
 it isn't and he can.
%
Androphobia:
 Fear of men.
%
Anoint, v.:
 To grease a king or other great functionary already sufficiently
 slippery.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Anthony's Law of Force:
 Don't force it; get a larger hammer.
%
Anthony's Law of the Workshop:
 Any tool when dropped, will roll into the least accessible
 corner of the workshop.

Corollary:
 On the way to the corner, any dropped tool will first strike
 your toes.
%
Antonym, n.:
 The opposite of the word you're trying to think of.
%
Aphasia:
 Loss of speech in social scientists when asked
 at parties, "But of what use is your research?"
%
aphorism, n.:
 A concise, clever statement.
afterism, n.:
 A concise, clever statement you don't think of until too late.
  -- James Alexander Thom
%
Appendix:
 A portion of a book, for which nobody yet has discovered any use.
%
Applause, n:
 The echo of a platitude from the mouth of a fool.
  -- Ambrose Bierce
%
aquadextrous, adj.:
 Possessing the ability to turn the bathtub faucet on and off
 with your toes.
  -- Rich Hall, "Sniglets"
%
Arbitrary systems, pl.n.:
 Systems about which nothing general can be said, save "nothing
 general can be said."
%
Arithmetic:
 An obscure art no longer practiced in the world's developed countries.
%
Armadillo:
 To provide weapons to a Spanish pickle.
%
Armor's Axiom:
 Virtue is the failure to achieve vice.
%
Armstrong's Collection Law:
 If the check is truly in the mail,
 it is surely made out to someone else.
%
Arnold's Addendum:
 Anything not fitting into these categories causes cancer in rats.
%
Arnold's Laws of Documentation:
 (1) If it should exist, it doesn't.
 (2) If it does exist, it's out of date.
 (3) Only documentation for useless programs transcends the
     first two laws.
%
Arthur's Laws of Love:
 (1) People to whom you are attracted invariably think you
     remind them of someone else.
 (2) The love letter you finally got the courage to send will be
     delayed in the mail long enough for you to make a fool of
     yourself in person.
%
ASCII:
 The control code for all beginning programmers and those who would
 become computer literate.  Etymologically, the term has come down as
 a contraction of the often-repeated phrase "ascii and you shall
 receive."
  -- Robb Russon
%
Atlanta:
 An entire city surrounded by an airport.
%
Auction:
 A gyp off the old block.
%
audophile, n:
 Someone who listens to the equipment instead of the music.
%
Authentic:
 Indubitably true, in somebody's opinion.
%
Automobile, n.:
 A four-wheeled vehicle that runs up hills and down pedestrians.
%
Bachelor:
 A guy who is footloose and fiancee-free.
%
Bachelor:
 A man who chases women and never Mrs. one.
%
Backward conditioning:
 Putting saliva in a dog's mouth in an attempt to make a bell ring.
%
Bagbiter:
 1. n.; Equipment or program that fails, usually intermittently.  2.
adj.: Failing hardware or software.  "This bagbiting system won't let me get
out of spacewar." Usage: verges on obscenity.  Grammatically separable; one
may speak of "biting the bag".  Synonyms: LOSER, LOSING, CRETINOUS,
BLETCHEROUS, BARFUCIOUS, CHOMPER, CHOMPING.
%
Bagdikian's Observation:
 Trying to be a first-rate reporter on the average American newspaper
 is like trying to play Bach's "St. Matthew Passion" on a ukelele.
%
Baker's First Law of Federal Geometry:
 A block grant is a solid mass of money surrounded on all sides by
 governors.
%
Ballistophobia:
 Fear of bullets;
Otophobia:
 Fear of opening one's eyes.
Peccatophobia:
 Fear of sinning.
Taphephobia:
 Fear of being buried alive.
Sitophobia:
 Fear of food.
Trichophobbia:
 Fear of hair.
Vestiphobia:
 Fear of clothing.
%
Banacek's Eighteenth Polish Proverb:
 The hippo has no sting, but the wise man would rather be sat upon
 by the bee.
%
Banectomy, n.:
 The removal of bruises on a banana.
  -- Rich Hall, "Sniglets"
%
Barach's Rule:
 An alcoholic is a person who drinks more than his own physician.
%
Barbara's Rules of Bitter Experience:
 (1) When you empty a drawer for his clothes
     and a shelf for his toiletries, the relationship ends.
 (2) When you finally buy pretty stationary
     to continue the correspondence, he stops writing.
%
Barker's Proof:
 Proofreading is more effective after publication.
%
Barometer, n.:
 An ingenious instrument which indicates what kind of weather we
 are having.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Barth's Distinction:
 There are two types of people: those who divide people into two
 types, and those who don't.
%
Baruch's Observation:
 If all you have is a hammer, everything looks like a nail.
%
Basic Definitions of Science:
 If it's green or wiggles, it's biology.
 If it stinks, it's chemistry.
 If it doesn't work, it's physics.
%
BASIC, n.:
 A programming language.  Related to certain social diseases in
 that those who have it will not admit it in polite company.
%
Bathquake, n.:
 The violent quake that rattles the entire house when the water
 faucet is turned on to a certain point.
  -- Rich Hall, "Sniglets"
%
Battle, n.:
 A method of untying with the teeth a political knot that
 will not yield to the tongue.
  -- Ambrose Bierce
%
Beauty, n.:
 The power by which a woman charms a lover and terrifies a husband.
  -- Ambrose Bierce
%
Beauty:
 What's in your eye when you have a bee in your hand.
%
Begathon, n.:
 A multi-day event on public television, used to raise money so
 you won't have to watch commercials.
%
Beifeld's Principle:
 The probability of a young man meeting a desirable and receptive
 young female increases by pyramidical progression when he
 is already in the company of (1) a date, (2) his wife, (3) a
 better-looking and richer male friend.
  -- R. Beifeld
%
belief, n:
 Something you do not believe.
%
Bennett's Laws of Horticulture:
 (1) Houses are for people to live in.
 (2) Gardens are for plants to live in.
 (3) There is no such thing as a houseplant.
%
Benson's Dogma:
 ASCII is our god, and Unix is his profit.
%
Bershere's Formula for Failure:
 There are only two kinds of people who fail: those who
 listen to nobody... and those who listen to everybody.
%
beta test, v:
 To voluntarily entrust one's data, one's livelihood and one's
 sanity to hardware or software intended to destroy all three.
 In earlier days, virgins were often selected to beta test volcanos.
%
Bierman's Laws of Contracts:
 (1) In any given document, you can't cover all the "what if's".
 (2) Lawyers stay in business resolving all the unresolved "what if's".
 (3) Every resolved "what if" creates two unresolved "what if's".
%
Bilbo's First Law:
 You cannot count friends that are all packed up in barrels.
%
Binary, adj.:
 Possessing the ability to have friends of both sexes.
%
Bing's Rule:
 Don't try to stem the tide -- move the beach.
%
Bipolar, adj.:
 Refers to someone who has homes in Nome, Alaska, and Buffalo, New York.
%
birth, n:
 The first and direst of all disasters.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
bit, n:
 A unit of measure applied to color.  Twenty-four-bit color
 refers to expensive $3 color as opposed to the cheaper 25
 cent, or two-bit, color that use to be available a few years ago.
%
Bizoos, n.:
 The millions of tiny individual bumps that make up a basketball.
  -- Rich Hall, "Sniglets"
%
blithwapping:
 Using anything BUT a hammer to hammer a nail into the
 wall, such as shoes, lamp bases, doorstops, etc.
  -- "Sniglets", Rich Hall & Friends
%
Bloom's Seventh Law of Litigation:
 The judge's jokes are always funny.
%
Blore's Razor:
 Given a choice between two theories, take the one which is funnier.
%
Blutarsky's Axiom:
 Nothing is impossible for the man who will not listen to reason.
%
Boling's postulate:
 If you're feeling good, don't worry.  You'll get over it.
%
Bolub's Fourth Law of Computerdom:
 Project teams detest weekly progress reporting because it so
 vividly manifests their lack of progress.
%
Bombeck's Rule of Medicine:
 Never go to a doctor whose office plants have died.
%
Boob's Law:
 You always find something in the last place you look.
%
Booker's Law:
 An ounce of application is worth a ton of abstraction.
%
Bore, n.:
 A guy who wraps up a two-minute idea in a two-hour vocabulary.
  -- Walter Winchell
%
Bore, n.:
 A person who talks when you wish him to listen.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Boren's Laws:
 (1) When in charge, ponder.
 (2) When in trouble, delegate.
 (3) When in doubt, mumble.
%
boss, n:
 According to the Oxford English Dictionary, in the Middle Ages the
 words "boss" and "botch" were largely synonymous, except that boss,
 in addition to meaning "a supervisor of workers" also meant "an
 ornamental stud."
%
Boucher's Observation:
 He who blows his own horn always plays the music
 several octaves higher than originally written.
%
Bower's Law:
 Talent goes where the action is.
%
Bowie's Theorem:
 If an experiment works, you must be using the wrong equipment.
%
boy, n:
 A noise with dirt on it.
%
Bradley's Bromide:
 If computers get too powerful, we can organize
 them into a committee -- that will do them in.
%
Brady's First Law of Problem Solving:
 When confronted by a difficult problem, you can solve it more
 easily by reducing it to the question, "How would the Lone Ranger
 have handled this?"
%
brain, n:
 The apparatus with which we think that we think.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
brain, v: [as in "to brain"]
 To rebuke bluntly, but not pointedly; to dispel a source
 of error in an opponent.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
brain-damaged, generalization of "Honeywell Brain Damage" (HBD), a
theoretical disease invented to explain certain utter cretinisms in
Multics, adj:
 Obviously wrong; cretinous; demented.  There is an implication
 that the person responsible must have suffered brain damage,
 because he/she should have known better.  Calling something
 brain-damaged is bad; it also implies it is unusable.
%
Bride, n.:
 A woman with a fine prospect of happiness behind her.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
briefcase, n:
 A trial where the jury gets together and forms a lynching party.
%
broad-mindedness, n:
 The result of flattening high-mindedness out.
%
Brogan's Constant:
 People tend to congregate in the back of the church and the
 front of the bus.
%
brokee, n:
 Someone who buys stocks on the advice of a broker.
%
Brontosaurus Principle:
 Organizations can grow faster than their brains can manage them
 in relation to their environment and to their own physiology:  when
 this occurs, they are an endangered species.
  -- Thomas K. Connellan
%
Brook's Law:
 Adding manpower to a late software project makes it later.
%
Brooke's Law:
 Whenever a system becomes completely defined, some damn fool
 discovers something which either abolishes the system or
 expands it beyond recognition.
%
Bubble Memory, n.:
 A derogatory term, usually referring to a person's intelligence.
 See also "vacuum tube".
%
Bucy's Law:
 Nothing is ever accomplished by a reasonable man.
%
Bug, n.:
 An aspect of a computer program which exists because the
 programmer was thinking about Jumbo Jacks or stock options when s/he
 wrote the program.

Fortunately, the second-to-last bug has just been fixed.
  -- Ray Simard
%
bug, n:
 A son of a glitch.
%
bug, n:
 An elusive creature living in a program that makes it incorrect.
 The activity of "debugging", or removing bugs from a program, ends
 when people get tired of doing it, not when the bugs are removed.
  -- "Datamation", January 15, 1984
%
Bugs, pl. n.:
 Small living things that small living boys throw on small living girls.
%
Bumper sticker:
 All the parts falling off this car are of the very finest
 British manufacture.
%
Bunker's Admonition:
 You cannot buy beer; you can only rent it.
%
Burbulation:
 The obsessive act of opening and closing a refrigerator door in
 an attempt to catch it before the automatic light comes on.
  -- "Sniglets", Rich Hall & Friends
%
Bureau Termination, Law of:
 When a government bureau is scheduled to be phased out,
 the number of employees in that bureau will double within
 12 months after the decision is made.
%
bureaucracy, n:
 A method for transforming energy into solid waste.
%
Bureaucrat, n.:
 A person who cuts red tape sideways.
  -- J. McCabe
%
bureaucrat, n:
 A politician who has tenure.
%
Burke's Postulates:
 Anything is possible if you don't know what you are talking about.
 Don't create a problem for which you do not have the answer.
%
Burn's Hog Weighing Method:
 (1) Get a perfectly symmetrical plank and balance it across a sawhorse.
 (2) Put the hog on one end of the plank.
 (3) Pile rocks on the other end until the plank is again perfectly
     balanced.
 (4) Carefully guess the weight of the rocks.
  -- Robert Burns
%
buzzword, n:
 The fly in the ointment of computer literacy.
%
byob, v:
 Believing Your Own Bull
%
C, n:
 A programming language that is sort of like Pascal except more like
 assembly except that it isn't very much like either one, or anything
 else.  It is either the best language available to the art today, or
 it isn't.
  -- Ray Simard
%
Cabbage, n.:
 A familiar kitchen-garden vegetable about as large and wise as
 a man's head.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Cache:
 A very expensive part of the memory system of a computer that no one
 is supposed to know is there.
%
Cahn's Axiom:
 When all else fails, read the instructions.
%
Campbell's Law:
 Nature abhors a vacuous experimenter.
%
Canada Bill Jones's Motto:
 It's morally wrong to allow suckers to keep their money.

Canada Bill Jones's Supplement:
 A Smith and Wesson beats four aces.
%
Canonical, adj.:
 The usual or standard state or manner of something.  A true story:
One Bob Sjoberg, new at the MIT AI Lab, expressed some annoyance at the use
of jargon.  Over his loud objections, we made a point of using jargon as
much as possible in his presence, and eventually it began to sink in.
Finally, in one conversation, he used the word "canonical" in jargon-like
fashion without thinking.
 Steele: "Aha!  We've finally got you talking jargon too!"
 Stallman: "What did he say?"
 Steele: "He just used `canonical' in the canonical way."
%
Captain Penny's Law:
 You can fool all of the people some of the time, and
 some of the people all of the time, but you Can't Fool Mom.
%
Carperpetuation (kar' pur pet u a shun), n.:
 The act, when vacuuming, of running over a string at least a
 dozen times, reaching over and picking it up, examining it, then
 putting it back down to give the vacuum one more chance.
  -- Rich Hall, "Sniglets"
%
Carson's Consolation:
 Nothing is ever a complete failure.
 It can always be used as a bad example.
%
Carson's Observation on Footwear:
 If the shoe fits, buy the other one too.
%
Carswell's Corollary:
 Whenever man comes up with a better mousetrap,
 nature invariably comes up with a better mouse.
%
Cat, n.:
 Lapwarmer with built-in buzzer.
%
cerebral atrophy, n:
 The phenomena which occurs as brain cells become weak and sick, and
impair the brain's performance.  An abundance of these "bad" cells can cause
symptoms related to senility, apathy, depression, and overall poor academic
performance.  A certain small number of brain cells will deteriorate due to
everday activity, but large amounts are weakened by intense mental effort
and the assimilation of difficult concepts.  Many college students become
victims of this dread disorder due to poor habits such as overstudying.

cerebral darwinism, n:
 The theory that the effects of cerebral atrophy can be reversed
through the purging action of heavy alcohol consumption.  Large amounts of
alcohol cause many brain cells to perish due to oxygen deprivation.  Through
the process of natural selection, the weak and sick brain cells will die
first, leaving only the healthy cells.  This wonderful process leaves the
imbiber with a healthier, more vibrant brain, and increases mental capacity.
Thus, the devastating effects of cerebral atrophy are reversed, and academic
performance actually increases beyond previous levels.
%
Chamberlain's Laws:
 (1) The big guys always win.
 (2) Everything tastes more or less like chicken.
%
character density, n.:
 The number of very weird people in the office.
%
Charity, n.:
 A thing that begins at home and usually stays there.
%
checkuary, n:
 The thirteenth month of the year.  Begins New Year's Day and ends
 when a person stops absentmindedly writing the old year on his checks.
%
Chef, n.:
 Any cook who swears in French.
%
Cheit's Lament:
 If you help a friend in need, he is sure to remember you--
 the next time he's in need.
%
Chemicals, n.:
 Noxious substances from which modern foods are made.
%
Cheops' Law:
 Nothing ever gets built on schedule or within budget.
%
Chicago Transit Authority Rider's Rule #36:
 Never ever ask the tough looking gentleman wearing El Rukn headgear
 where he got his "pyramid powered pizza warmer".
  -- Chicago Reader 3/27/81
%
Chicago Transit Authority Rider's Rule #84:
 The CTA has complimentary pop-up timers available on request
 for overheated passengers.  When your timer pops up, the driver will
 cheerfully baste you.
  -- Chicago Reader 5/28/82
%
Chicken Soup:
 An ancient miracle drug containing equal parts of aureomycin,
 cocaine, interferon, and TLC.  The only ailment chicken soup
 can't cure is neurotic dependence on one's mother.
  -- Arthur Naiman, "Every Goy's Guide to Yiddish"
%
Chism's Law of Completion:
 The amount of time required to complete a government project is
 precisely equal to the length of time already spent on it.
%
Chisolm's First Corollary to Murphy's Second Law:
 When things just can't possibly get any worse, they will.
%
Christmas:
 A day set apart by some as a time for turkey, presents, cranberry
 salads, family get-togethers; for others, noted as having the best
 response time of the entire year.
%
Churchill's Commentary on Man:
 Man will occasionally stumble over the truth,
 but most of the time he will pick himself up and continue on.
%
Cinemuck, n.:
 The combination of popcorn, soda, and melted chocolate which
 covers the floors of movie theaters.
  -- Rich Hall, "Sniglets"
%
clairvoyant, n.:
 A person, commonly a woman, who has the power of seeing that
 which is invisible to her patron -- namely, that he is a blockhead.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Clarke's Conclusion:
 Never let your sense of morals interfere with doing the right thing.
%
Clay's Conclusion:
 Creativity is great, but plagiarism is faster.
%
clone, n:
 1. An exact duplicate, as in "our product is a clone of their
 product."  2. A shoddy, spurious copy, as in "their product
 is a clone of our product."
%
Clovis' Consideration of an Atmospheric Anomaly:
 The perversity of nature is nowhere better demonstrated
 than by the fact that, when exposed to the same atmosphere,
 bread becomes hard while crackers become soft.
%
COBOL:
 An exercise in Artificial Inelegance.
%
COBOL:
 Completely Over and Beyond reason Or Logic.
%
Cohen's Law:
 There is no bottom to worse.
%
Cohn's Law:
 The more time you spend in reporting on what you are doing, the less
 time you have to do anything.  Stability is achieved when you spend
 all your time reporting on the nothing you are doing.
%
Cold, adj.:
 When the politicians walk around with their hands in their own pockets.
%
Cole's Law:
 Thinly sliced cabbage.
%
Collaboration, n.:
 A literary partnership based on the false assumption that the
 other fellow can spell.
%
College:
 The fountains of knowledge, where everyone goes to drink.
%
Colvard's Logical Premises:
 All probabilities are 50%.
 Either a thing will happen or it won't.

Colvard's Unconscionable Commentary:
 This is especially true when dealing with someone you're attracted to.

Grelb's Commentary:
 Likelihoods, however, are 90% against you.
%
Command, n.:
 Statement presented by a human and accepted by a computer in
 such a manner as to make the human feel as if he is in control.
%
comment:
 A superfluous element of a source program included so the
 programmer can remember what the hell it was he was doing
 six months later.  Only the weak-minded need them, according
 to those who think they aren't.
%
Commitment, n.:
 [The difference between involvement and] Commitment can be
 illustrated by a breakfast of ham and eggs.  The chicken was
 involved, the pig was committed.
%
Committee Rules:
 (1) Never arrive on time, or you will be stamped a beginner.
 (2) Don't say anything until the meeting is half over; this
     stamps you as being wise.
 (3) Be as vague as possible; this prevents irritating the
     others.
 (4) When in doubt, suggest that a subcommittee be appointed.
 (5) Be the first to move for adjournment; this will make you
     popular -- it's what everyone is waiting for.
%
Committee, n.:
 A group of men who individually can do nothing but as a group
 decide that nothing can be done.
  -- Fred Allen
%
Commoner's three laws of ecology:
 (1) No action is without side-effects.
 (2) Nothing ever goes away.
 (3) There is no free lunch.
%
Complex system:
 One with real problems and imaginary profits.
%
Compliment, n.:
 When you say something to another which everyone knows isn't true.
%
compuberty, n:
 The uncomfortable period of emotional and hormonal changes a
 computer experiences when the operating system is upgraded and
 a sun4 is put online sharing files.
%
Computer science:
 (1) A study akin to numerology and astrology, but lacking the
    precision of the former and the success of the latter.
 (2) The protracted value analysis of algorithms.
 (3) The costly enumeration of the obvious.
 (4) The boring art of coping with a large number of trivialities.
 (5) Tautology harnessed in the service of Man at the speed of light.
 (6) The Post-Turing decline in formal systems theory.
%
Computer, n.:
 An electronic entity which performs sequences of useful steps in a
 totally understandable, rigorously logical manner.  If you believe
 this, see me about a bridge I have for sale in Manhattan.
%
Concept, n.:
 Any "idea" for which an outside consultant billed you more than
 $25,000.
%
Conference, n.:
 A special meeting in which the boss gathers subordinates to hear
 what they have to say, so long as it doesn't conflict with what
 he's already decided to do.
%
Confidant, confidante, n:
 One entrusted by A with the secrets of B, confided to himself by C.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Confirmed bachelor:
 A man who goes through life without a hitch.
%
Conjecture: All odd numbers are prime.
 Mathematician's Proof:
  3 is prime.  5 is prime.  7 is prime.  By induction, all
  odd numbers are prime.
 Physicist's Proof:
  3 is prime.  5 is prime.  7 is prime.  9 is experimental
  error.  11 is prime.  13 is prime ...
 Engineer's Proof:
  3 is prime.  5 is prime.  7 is prime.  9 is prime.
  11 is prime.  13 is prime ...
 Computer Scientists's Proof:
  3 is prime.  3 is prime.  3 is prime.  3 is prime...
%
Connector Conspiracy, n:
 [probably came into prominence with the appearance of the KL-10,
 none of whose connectors match anything else] The tendency of
 manufacturers (or, by extension, programmers or purveyors of anything)
 to come up with new products which don't fit together with the old
 stuff, thereby making you buy either all new stuff or expensive
 interface devices.
%
Consent decree:
 A document in which a hapless company consents never to commit
 in the future whatever heinous violations of Federal law it
 never admitted to in the first place.
%
Consultant, n.:
 (1) Someone you pay to take the watch off your wrist and tell
 you what time it is. (2) (For resume use) The working title
 of anyone who doesn't currently hold a job. Motto: Have
 Calculator, Will Travel.
%
Consultant, n.:
 [From con "to defraud, dupe, swindle," or, possibly, French con
 (vulgar) "a person of little merit" + sult elliptical form of
 "insult."]  A tipster disguised as an oracle, especially one who
 has learned to decamp at high speed in spite of a large briefcase
 and heavy wallet.
%
Consultant, n.:
 An ordinary man a long way from home.
%
consultant, n.:
 Someone who knowns 101 ways to make love, but can't get a date.
%
Consultant, n.:
 Someone who'd rather climb a tree and tell a lie than stand on
 the ground and tell the truth.
%
Consultation, n.:
 Medical term meaning "to share the wealth."
%
Conversation, n.:
 A vocal competition in which the one who is catching his breath
 is called the listener.
%
Conway's Law:
 In any organization there will always be one person who knows
 what is going on.

 This person must be fired.
%
Copying machine, n.:
 A device that shreds paper, flashes mysteriously coded messages,
 and makes duplicates for everyone in the office who isn't
 interested in reading them.
%
Coronation, n.:
 The ceremony of investing a sovereign with the outward and visible
 signs of his divine right to be blown skyhigh with a dynamite bomb.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Correspondence Corollary:
 An experiment may be considered a success if no more than half
 your data must be discarded to obtain correspondence with your theory.
%
Corry's Law:
 Paper is always strongest at the perforations.
%
court, n.:
 A place where they dispense with justice.
  -- Arthur Train
%
Coward, n.:
 One who in a perilous emergency thinks with his legs.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Creditor, n.:
 A man who has a better memory than a debtor.
%
Crenna's Law of Political Accountability:
 If you are the first to know about something bad, you are going to be
 held responsible for acting on it, regardless of your formal duties.
%
critic, n.:
 A person who boasts himself hard to please because nobody tries
 to please him.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Croll's Query:
 If tin whistles are made of tin, what are foghorns made of?
%
Cropp's Law:
 The amount of work done varies inversly with the time spent in the
 office.
%
Cruickshank's Law of Committees:
 If a committee is allowed to discuss a bad idea long enough, it
 will inevitably decide to implement the idea simply because so
 much work has already been done on it.
%
cursor address, n:
 "Hello, cursor!"
  -- Stan Kelly-Bootle, "The Devil's DP Dictionary"
%
Cursor, n.:
 One whose program will not run.
  -- Robb Russon
%
curtation, n.:
 The enforced compression of a string in the fixed-length field
environment.
 The problem of fitting extremely variable-length strings such as names,
addresses, and item descriptions into fixed-length records is no trivial
matter.  Neglect of the subtle art of curtation has probably alienated more
people than any other aspect of data processing.  You order Mozart's "Don
Giovanni" from your record club, and they invoice you $24.95 for MOZ DONG.
The witless mapping of the sublime onto the ridiculous!  Equally puzzling is
the curtation that produces the same eight characters, THE BEST, whether you
order "The Best of Wagner", "The Best of Schubert", or "The Best of the Turds".
Similarly, wine lovers buying from computerized wineries twirl their glasses,
check their delivery notes, and inform their friends, "A rather innocent,
possibly overtruncated CAB SAUV 69 TAL."  The squeezing of fruit into 10
columns has yielded such memorable obscenities as COX OR PIP.  The examples
cited are real, and the curtational methodology which produced them is still
with us.

MOZ DONG n.
 Curtation of Don Giovanni by Wolfgang Amadeus Mozart and Lorenzo da
Ponte, as performed by the computerized billing ensemble of the Internat'l
Preview Society, Great Neck (sic), N.Y.
  -- Stan Kelly-Bootle, "The Devil's DP Dictionary"
%
Cutler Webster's Law:
 There are two sides to every argument, unless a person
 is personally involved, in which case there is only one.
%
Cynic, n.:
 A blackguard whose faulty vision sees things as they are, not
 as they ought to be.  Hence the custom among the Scythians of plucking
 out a cynic's eyes to improve his vision.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Cynic, n.:
 Experienced.
%
Cynic, n.:
 One who looks through rose-colored glasses with a jaundiced eye.
%
Data, n.:
 An accrual of straws on the backs of theories.
%
Data, n.:
 Computerspeak for "information".  Properly pronounced
 the way Bostonians pronounce the word for a female child.
%
Davis' Law of Traffic Density:
 The density of rush-hour traffic is directly proportional to
 1.5 times the amount of extra time you allow to arrive on time.
%
Davis's Dictum:
 Problems that go away by themselves, come back by themselves.
%
Dawn, n.:
 The time when men of reason go to bed.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Deadwood, n.:
 Anyone in your company who is more senior than you are.
%
Death wish, n.:
 The only wish that always comes true, whether or not one wishes it to.
%
Decision maker, n.:
 The person in your office who was unable to form a task force
 before the music stopped.
%
default, n.:
 [Possibly from Black English "De fault wid dis system is you,
 mon."] The vain attempt to avoid errors by inactivity.  "Nothing will
 come of nothing: speak again." -- King Lear.
  -- Stan Kelly-Bootle, "The Devil's DP Dictionary"
%
Default, n.:
 The hardware's, of course.
%
Deja vu:
 French., already seen; unoriginal; trite.
 Psychol., The illusion of having previously experienced
 something actually being encountered for the first time.
 Psychol., The illusion of having previously experienced
 something actually being encountered for the first time.
%
Deliberation, n.:
 The act of examining one's bread to determine which side it is
 buttered on.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Dentist, n.:
 A Prestidigitator who, putting metal in one's mouth, pulls
 coins out of one's pockets.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Denver, n.:
 A smallish city located just below the `O' in Colorado.
%
design, v.:
 What you regret not doing later on.
%
DeVries' Dilemma:
 If you hit two keys on the typewriter, the one you don't want
 hits the paper.
%
Dibble's First Law of Sociology:
 Some do, some don't.
%
Die, v.:
 To stop sinning suddenly.
  -- Elbert Hubbard
%
Dinner suggestion #302 (Hacker's De-lite):
 1 tin imported Brisling sardines in tomato sauce
 1 pouch Chocolate Malt Carnation Instant Breakfast
 1 carton milk
%
diplomacy, n:
 Lying in state.
%
Dirksen's Three Laws of Politics:
 (1) Get elected.
 (2) Get re-elected.
 (3) Don't get mad, get even.
  -- Sen. Everett Dirksen
%
disbar, n:
 As distinguished from some other bar.
%
Distinctive, adj.:
 A different color or shape than our competitors.
%
Distress, n.:
 A disease incurred by exposure to the prosperity of a friend.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
divorce, n:
 A change of wife.
%
Documentation:
 Instructions translated from Swedish by Japanese for English
 speaking persons.
%
double-blind experiment, n:
 An experiment in which the chief researcher believes he is
 fooling both the subject and the lab assistant.  Often accompanied
 by a strong belief in the tooth fairy.
%
Dow's Law:
 In a hierarchical organization, the higher the level,
 the greater the confusion.
%
Drakenberg's Discovery:
 If you can't seem to find your glasses,
 it's probably because you don't have them on.
%
Drew's Law of Highway Biology:
 The first bug to hit a clean windshield lands directly in front
 of your eyes.
%
drug, n:
 A substance that, injected into a rat, produces a scientific paper.
%
Ducharme's Precept:
 Opportunity always knocks at the least opportune moment.

Ducharme's Axiom:
 If you view your problem closely enough you will recognize
 yourself as part of the problem.
%
Duty, n:
 What one expects from others.
  -- Oscar Wilde
%
Eagleson's Law:
 Any code of your own that you haven't looked at for six or more
 months, might as well have been written by someone else.  (Eagleson
 is an optimist, the real number is more like three weeks.)
%
economics, n.:
 Economics is the study of the value and meaning of J.K. Galbraith.
  -- Mike Harding, "The Armchair Anarchist's Almanac"
%
Economies of scale:
 The notion that bigger is better.  In particular, that if you want
 a certain amount of computer power, it is much better to buy one
 biggie than a bunch of smallies.  Accepted as an article of faith
 by people who love big machines and all that complexity.  Rejected
 as an article of faith by those who love small machines and all
 those limitations.
%
economist, n:
 Someone who's good with figures, but doesn't have enough
 personality to become an accountant.
%
Egotism, n:
 Doing the New York Times crossword puzzle with a pen.

Egotist, n:
 A person of low taste, more interested in himself than me.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Ehrman's Commentary:
 (1) Things will get worse before they get better.
 (2) Who said things would get better?
%
Elbonics, n.:
 The actions of two people maneuvering for one armrest in a movie
 theatre.
  -- "Sniglets", Rich Hall & Friends
%
Electrocution, n.:
 Burning at the stake with all the modern improvements.
%
Elephant, n.:
 A mouse built to government specifications.
%
Eleventh Law of Acoustics:
 In a minimum-phase system there is an inextricable link between
 frequency response, phase response and transient response, as they
 are all merely transforms of one another.  This combined with
 minimalization of open-loop errors in output amplifiers and correct
 compensation for non-linear passive crossover network loading can
 lead to a significant decrease in system resolution lost.  However,
 of course, this all means jack when you listen to Pink Floyd.
%
Emacs, n.:
 A slow-moving parody of a text editor.
%
Emerson's Law of Contrariness:
 Our chief want in life is somebody who shall make us do what we
 can.  Having found them, we shall then hate them for it.
%
Encyclopedia Salesmen:
 Invite them all in.  Nip out the back door.  Phone the police
 and tell them your house is being burgled.
  -- Mike Harding, "The Armchair Anarchist's Almanac"
%
Endless Loop, n.:
 see Loop, Endless.
Loop, Endless, n.:
 see Endless Loop.
  -- Random Shack Data Processing Dictionary
%
Engram, n.:
 1. The physical manifestation of human memory -- "the engram."
2. A particular memory in physical form.  [Usage note:  this term is no longer
in common use.  Prior to Wilson and Magruder's historic discovery, the nature
of the engram was a topic of intense speculation among neuroscientists,
psychologists, and even computer scientists.  In 1994 Professors M. R. Wilson
and W. V. Magruder, both of Mount St. Coax University in Palo Alto, proved
conclusively that the mammalian brain is hardwired to interpret a set of
thirty seven genetically transmitted cooperating TECO macros.  Human memory
was shown to reside in 1 million Q-registers as Huffman coded uppercase-only
ASCII strings.  Interest in the engram has declined substantially since that
time.]
  -- New Century Unabridged English Dictionary,
     3rd edition, 2007 A.D.
%
enhance, v.:
 To tamper with an image, usually to its detriment.
%
Entreprenuer, n.:
 A high-rolling risk taker who would rather
 be a spectacular failure than a dismal success.
%
Envy, n.:
 Wishing you'd been born with an unfair advantage,
 instead of having to try and acquire one.
%
Epperson's law:
 When a man says it's a silly, childish game, it's probably
 something his wife can beat him at.
%
Etymology, n.:
 Some early etymological scholars came up with derivations that
 were hard for the public to believe.  The term "etymology" was formed
 from the Latin "etus" ("eaten"), the root "mal" ("bad"), and "logy"
 ("study of").  It meant "the study of things that are hard to swallow."
  -- Mike Kellen
%
Every Horse has an Infinite Number of Legs (proof by intimidation):

Horses have an even number of legs.  Behind they have two legs, and in
front they have fore-legs.  This makes six legs, which is certainly an
odd number of legs for a horse.  But the only number that is both even
and odd is infinity.  Therefore, horses have an infinite number of
legs.  Now to show this for the general case, suppose that somewhere,
there is a horse that has a finite number of legs.  But that is a horse
of another color, and by the lemma ["All horses are the same color"],
that does not exist.
%
Every program has (at least) two purposes:
 the one for which it was written and another for which it wasn't.
%
Expense Accounts, n.:
 Corporate food stamps.
%
Experience, n.:
 Something you don't get until just after you need it.
  -- Olivier
%
Expert, n.:
 Someone who comes from out of town and shows slides.
%
Extract from Official Sweepstakes Rules:

  NO PURCHASE REQUIRED TO CLAIM YOUR PRIZE

To claim your prize without purchase, do the following: (a) Carefully
cut out your computer-printed name and address from upper right hand
corner of the Prize Claim Form. (b) Affix computer-printed name and
address -- with glue or cellophane tape (no staples or paper clips) --
to a 3x5 inch index card.  (c) Also cut out the "No" paragraph (lower
left hand corner of Prize Claim Form) and affix it to the 3x5 card
below your address label. (d) Then print on your 3x5 card, above your
computer-printed name and address the words "CARTER & VAN PEEL
SWEEPSTAKES" (Use all capital letters.)  (e) Finally place 3x5 card
(without bending) into a plain envelope [NOTE: do NOT use the the
Official Prize Claim and CVP Perfume Reply Envelope or you may be
disqualified], and mail to: CVP, Box 1320, Westbury, NY 11595.  Print
this address correctly.  Comply with above instructions carefully and
completely or you may be disqualified from receiving your prize.
%
Fairy Tale, n.:
 A horror story to prepare children for the newspapers.
%
Fakir, n:
 A psychologist whose charismatic data have inspired almost
 religious devotion in his followers, even though the sources
 seem to have shinnied up a rope and vanished.
%
falsie salesman, n:
 Fuller bust man.
%
Famous last words:
%
Famous last words:
 (1) "Don't worry, I can handle it."
 (2) "You and what army?"
 (3) "If you were as smart as you think you are, you wouldn't be
      a cop."
%
Famous last words:
 (1) Don't unplug it, it will just take a moment to fix.
 (2) Let's take the shortcut, he can't see us from there.
 (3) What happens if you touch these two wires tog--
 (4) We won't need reservations.
 (5) It's always sunny there this time of the year.
 (6) Don't worry, it's not loaded.
 (7) They'd never (be stupid enough to) make him a manager.
 (8) Don't worry!  Women love it!
%
Famous quotations:
 " "
  -- Charlie Chaplin

 " "
  -- Harpo Marx

 " "
  -- Marcel Marceau
%
Famous, adj.:
 Conspicuously miserable.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
feature, n:
 A surprising property of a program.  Occasionaly documented.  To
 call a property a feature sometimes means the author did not
 consider that case, and the program makes an unexpected, though
 not necessarily wrong response.  See BUG.  "That's not a bug, it's
 a feature!"  A bug can be changed to a feature by documenting it.
%
fenderberg, n.:
 The large glacial deposits that form on the insides
 of car fenders during snowstorms.
  -- "Sniglets", Rich Hall & Friends
%
Ferguson's Precept:
 A crisis is when you can't say "let's forget the whole thing."
%
Fidelity, n.:
 A virtue peculiar to those who are about to be betrayed.
%
Fifth Law of Applied Terror:
 If you are given an open-book exam, you will forget your book.

Corollary:
 If you are given a take-home exam, you will forget where you live.
%
Fifth Law of Procrastination:
 Procrastination avoids boredom; one never has the feeling that
 there is nothing important to do.
%
File cabinet:
 A four drawer, manually activated trash compactor.
%
filibuster, n.:
 Throwing your wait around.
%
Finagle's Creed:
 Science is true.  Don't be misled by facts.
%
Finagle's Eighth Law:
 If an experiment works, something has gone wrong.

Finagle's Ninth Law:
 No matter what results are expected, someone is always willing to
 fake it.

Finagle's Tenth Law:
 No matter what the result someone is always eager to misinterpret it.

Finagle's Eleventh Law:
 No matter what occurs, someone believes it happened according to
 his pet theory.
%
Finagle's First Law:
 If an experiment works, something has gone wrong.
%
Finagle's First Law:
 To study a subject best, understand it thoroughly before you start.

Finagle's Second Law:
 Always keep a record of data -- it indicates you've been working.

Finagle's Fourth Law:
 Once a job is fouled up, anything done to improve it only makes
 it worse.

Finagle's Fifth Law:
 Always draw your curves, then plot your readings.

Finagle's Sixth Law:
 Don't believe in miracles -- rely on them.
%
Finagle's Second Law:
 No matter what the anticipated result, there will always be
 someone eager to (a) misinterpret it, (b) fake it, or (c) believe it
 happened according to his own pet theory.
%
Finagle's Seventh Law:
 The perversity of the universe tends toward a maximum.
%
Finagle's Third Law:
 In any collection of data, the figure most obviously correct,
 beyond all need of checking, is the mistake

Corollaries:
 (1) Nobody whom you ask for help will see it.
 (2) The first person who stops by, whose advice you really
     don't want to hear, will see it immediately.
%
Fine's Corollary:
 Functionality breeds Contempt.
%
Finster's Law:
 A closed mouth gathers no feet.
%
First Law of Bicycling:
 No matter which way you ride, it's uphill and against the wind.
%
First law of debate:
 Never argue with a fool.  People might not know the difference.
%
First Law of Procrastination:
 Procrastination shortens the job and places the responsibility
 for its termination on someone else (i.e., the authority who
 imposed the deadline).

Fifth Law of Procrastination:
 Procrastination avoids boredom; one never has the feeling that
 there is nothing important to do.
%
First Law of Socio-Genetics:
 Celibacy is not hereditary.
%
First Rule of History:
 History doesn't repeat itself -- historians merely repeat each other.
%
Fishbowl, n.:
 A glass-enclosed isolation cell where newly promoted managers are
 kept for observation.
%
Five rules for eternal misery:
 (1) Always try to exhort others to look upon you favorably.
 (2) Make lots of assumptions about situations and be sure to
     treat these assumptions as though they are reality.
 (3) Then treat each new situation as though it's a crisis.
 (4) Live in the past and future only (become obsessed with
     how much better things might have been or how much worse
     things might become).
 (5) Occasionally stomp on yourself for being so stupid as to
     follow the first four rules.
%
flannister, n.:
 The plastic yoke that holds a six-pack of beer together.
  -- "Sniglets", Rich Hall & Friends
%
Flon's Law:
 There is not now, and never will be, a language in
 which it is the least bit difficult to write bad programs.
%
flowchart, n. & v.:
 [From flow "to ripple down in rich profusion, as hair" + chart
"a cryptic hidden-treasure map designed to mislead the uninitiated."]
1. n. The solution, if any, to a class of Mascheroni construction
problems in which given algorithms require geometrical representation
using only the 35 basic ideograms of the ANSI template.  2. n. Neronic
doodling while the system burns.  3. n. A low-cost substitute for
wallpaper.  4. n.  The innumerate misleading the illiterate.  "A
thousand pictures is worth ten lines of code." -- The Programmer's
Little Red Vade Mecum, Mao Tse T'umps.  5. v.intrans. To produce
flowcharts with no particular object in mind.  6. v.trans. To obfuscate
(a problem) with esoteric cartoons.
  -- Stan Kelly-Bootle, "The Devil's DP Dictionary"
%
Flugg's Law:
 When you need to knock on wood is when you realize
 that the world is composed of vinyl, naugahyde and aluminum.
%
Fog Lamps, n.:
 Excessively (often obnoxiously) bright lamps mounted on the fronts
 of automobiles; used on dry, clear nights to indicate that the
 driver's brain is in a fog.  See also "Idiot Lights".
%
Foolproof Operation:
 No provision for adjustment.
%
Forecast, n.:
 A prediction of the future, based on the past, for
 which the forecaster demands payment in the present.
%
Forgetfulness, n.:
 A gift of God bestowed upon debtors in compensation for
 their destitution of conscience.
%
FORTUNE EXPLAINS WHAT JOB REVIEW CATCH PHRASES MEAN: #1
skilled oral communicator:
 Mumbles inaudibly when attempting to speak.  Talks to self.
 Argues with self.  Loses these arguments.

skilled written communicator:
 Scribbles well.  Memos are invariable illegible, except for
 the portions that attribute recent failures to someone else.

growth potential:
 With proper guidance, periodic counselling, and remedial training,
 the reviewee may, given enough time and close supervision, meet
 the minimum requirements expected of him by the company.

key company figure:
 Serves as the perfect counter example.
%
FORTUNE EXPLAINS WHAT JOB REVIEW CATCH PHRASES MEAN: #4
consistent:
 Reviewee hasn't gotten anything right yet, and it is anticipated
 that this pattern will continue throughout the coming year.

an excellent sounding board:
 Present reviewee with any number of alternatives, and implement
 them in the order precisely opposite of his/her specification.

a planner and organizer:
 Usually manages to put on socks before shoes.  Can match the
 animal tags on his clothing.
%
FORTUNE EXPLAINS WHAT JOB REVIEW CATCH PHRASES MEAN: #9
has management potential:
 Because of his intimate relationship with inanimate objects, the
 reviewee has been appointed to the critical position of department
 pencil monitor.

inspirational:
 A true inspiration to others.  ("There, but for the grace of God,
 go I.")

adapts to stress:
 Passes wind, water, or out depending upon the severity of the
 situation.

goal oriented:
 Continually sets low goals for himself, and usually fails
 to meet them.
%
Fortune's Rules for Memo Wars: #2

Given the incredible advances in sociocybernetics and telepsychology over
the last few years, we are now able to completely understand everything that
the author of an memo is trying to say.  Thanks to modern developments
in electrocommunications like notes, vnews, and electricity, we have an
incredible level of interunderstanding the likes of which civilization has
never known.  Thus, the possibility of your misinterpreting someone else's
memo is practically nil.  Knowing this, anyone who accuses you of having
done so is a liar, and should be treated accordingly.  If you *do* understand
the memo in question, but have absolutely nothing of substance to say, then
you have an excellent opportunity for a vicious ad hominem attack.  In fact,
the only *inappropriate* times for an ad hominem attack are as follows:

 1: When you agree completely with the author of an memo.
 2: When the author of the original memo is much bigger than you are.
 3: When replying to one of your own memos.
%
Fourth Law of Applied Terror:
 The night before the English History mid-term, your Biology
 instructor will assign 200 pages on planaria.

Corollary:
 Every instructor assumes that you have nothing else to do except
 study for that instructor's course.
%
Fourth Law of Revision:
 It is usually impractical to worry beforehand about
 interferences -- if you have none, someone will make one for you.
%
Fourth Law of Thermodynamics:
 If the probability of success is not almost one, it is damn near zero.
  -- David Ellis
%
Fresco's Discovery:
 If you knew what you were doing you'd probably be bored.
%
Fried's 1st Rule:
 Increased automation of clerical function
 invariably results in increased operational costs.
%
Friends, n.:
 People who borrow your books and set wet glasses on them.

 People who know you well, but like you anyway.
%
Frobnicate, v.:
 To manipulate or adjust, to tweak.  Derived from FROBNITZ. Usually
abbreviated to FROB.  Thus one has the saying "to frob a frob." See TWEAK
and TWIDDLE.  Usage: FROB, TWIDDLE, and TWEAK sometimes connote points along
a continuum.  FROB connotes aimless manipulation; TWIDDLE connotes gross
manipulation, often a coarse search for a proper setting; TWEAK connotes
fine-tuning.  If someone is turning a knob on an oscilloscope, then if he's
carefully adjusting it he is probably tweaking it; if he is just turning it
but looking at the screen he is probably twiddling it; but if he's just
doing it because turning a knob is fun, he's frobbing it.
%
Frobnitz, pl. Frobnitzem (frob'nitsm) n.:
 An unspecified physical object, a widget.  Also refers to electronic
black boxes.  This rare form is usually abbreviated to FROTZ, or more
commonly to FROB.  Also used are FROBNULE, FROBULE, and FROBNODULE.
Starting perhaps in 1979, FROBBOZ (fruh-bahz'), pl. FROBBOTZIM, has also
become very popular, largely due to its exposure via the Adventure spin-off
called Zork (Dungeon).  These can also be applied to non-physical objects,
such as data structures.
%
Fuch's Warning:
 If you actually look like your passport photo, you aren't well
 enough to travel.
%
Fudd's First Law of Opposition:
 Push something hard enough and it will fall over.
%
Fun experiments:
 Get a can of shaving cream, throw it in a freezer for about a week.
 Then take it out, peel the metal off and put it where you want...
 bedroom, car, etc.  As it thaws, it expands an unbelievable amount.
%
Fun Facts, #14:
 In table tennis, whoever gets 21 points first wins.  That's how
 it once was in baseball -- whoever got 21 runs first won.
%
Fun Facts, #63:
 The name California was given to the state by Spanish conquistadores.
 It was the name of an imaginary island, a paradise on earth, in the
 Spanish romance, "Les Serges de Esplandian", written by Montalvo in
 1510.
%
furbling, v.:
 Having to wander through a maze of ropes at an airport or bank
 even when you are the only person in line.
  -- Rich Hall, "Sniglets"
%
Galbraith's Law of Human Nature:
 Faced with the choice between changing one's mind and proving that
 there is no need to do so, almost everybody gets busy on the proof.
%
Genderplex, n.:
 The predicament of a person in a restaurant who is unable to
 determine his or her designated restroom (e.g., turtles and tortoises).
  -- Rich Hall, "Sniglets"
%
genealogy, n.:
 An account of one's descent from an ancestor
 who did not particularly care to trace his own.
  -- Ambrose Bierce
%
Genius, n.:
 A chemist who discovers a laundry additive that rhymes with "bright."
%
genius, n.:
 Person clever enough to be born in the right place at the right
 time of the right sex and to follow up this advantage by saying
 all the right things to all the right people.
%
genlock, n.:
 Why he stays in the bottle.
%
Gerrold's Laws of Infernal Dynamics:
 (1) An object in motion will always be headed in the wrong direction.
 (2) An object at rest will always be in the wrong place.
 (3) The energy required to change either one of these states
    will always be more than you wish to expend, but never so
    much as to make the task totally impossible.
%
Getting the job done is no excuse for not following the rules.

Corollary:
 Following the rules will not get the job done.
%
Gilbert's Discovery:
 Any attempt to use the new super glues results in the two pieces
 sticking to your thumb and index finger rather than to each other.
%
Ginsberg's Theorem:
 (1) You can't win.
 (2) You can't break even.
 (3) You can't even quit the game.

Freeman's Commentary on Ginsberg's theorem:
 Every major philosophy that attempts to make life seem
 meaningful is based on the negation of one part of Ginsberg's
 Theorem.  To wit:

 (1) Capitalism is based on the assumption that you can win.
 (2) Socialism is based on the assumption that you can break even.
 (3) Mysticism is based on the assumption that you can quit the game.
%
Ginsburg's Law:
 At the precise moment you take off your shoe in a shoe store, your
 big toe will pop out of your sock to see what's going on.
%
gleemites, n.:
 Petrified deposits of toothpaste found in sinks.
  -- "Sniglets", Rich Hall & Friends
%
Glib's Fourth Law of Unreliability:
 Investment in reliability will increase until it exceeds the
 probable cost of errors, or until someone insists on getting
 some useful work done.
%
Gnagloot, n.:
 A person who leaves all his ski passes on his jacket just to
 impress people.
  -- Rich Hall, "Sniglets"
%
Goda's Truism:
 By the time you get to the point where you can make ends meet,
 somebody moves the ends.
%
Godwin's Law (prov.  [Usenet]):
 As a Usenet discussion grows longer, the probability of a
 comparison involving Nazis or Hitler approaches one." There is a
 tradition in many groups that, once this occurs, that thread is
 over, and whoever mentioned the Nazis has automatically lost
 whatever argument was in progress.  Godwin's Law thus guarantees
 the existence of an upper bound on thread length in those groups.
%
Gold's Law:
 If the shoe fits, it's ugly.
%
Gold, n.:
 A soft malleable metal relatively scarce in distribution.  It
 is mined deep in the earth by poor men who then give it to rich
 men who immediately bury it back in the earth in great prisons,
 although gold hasn't done anything to them.
  -- Mike Harding, "The Armchair Anarchist's Almanac"
%
Goldenstern's Rules:
 (1) Always hire a rich attorney
 (2) Never buy from a rich salesman.
%
Gomme's Laws:
 (1) A backscratcher will always find new itches.
 (2) Time accelerates.
 (3) The weather at home improves as soon as you go away.
%
Gordon's first law:
 If a research project is not worth doing, it is not worth doing well.
%
Gordon's Law:
 If you think you have the solution, the question was poorly phrased.
%
gossip, n.:
 Hearing something you like about someone you don't.
  -- Earl Wilson
%
Goto, n.:
 A programming tool that exists to allow structured programmers
 to complain about unstructured programmers.
  -- Ray Simard
%
Government's Law:
 There is an exception to all laws.
%
Grabel's Law:
 2 is not equal to 3 -- not even for large values of 2.
%
Grandpa Charnock's Law:
 You never really learn to swear until you learn to drive.

 [I thought it was when your kids learned to drive.  Ed.]
%
grasshopotomaus:
 A creature that can leap to tremendous heights... once.
%
Gravity:
 What you get when you eat too much and too fast.
%
Gray's Law of Programming:
 `n+1' trivial tasks are expected to be accomplished in the same
 time as `n' tasks.

Logg's Rebuttal to Gray's Law:
 `n+1' trivial tasks take twice as long as `n' trivial tasks.
%
Great American Axiom:
 Some is good, more is better, too much is just right.
%
Green's Law of Debate:
 Anything is possible if you don't know what you're talking about.
%
Greener's Law:
 Never argue with a man who buys ink by the barrel.
%
Grelb's Reminder:
 Eighty percent of all people consider themselves to be above
 average drivers.
%
Griffin's Thought:
 When you starve with a tiger, the tiger starves last.
%
Grinnell's Law of Labor Laxity:
 At all times, for any task, you have not got enough done today.
%
Guillotine, n.:
 A French chopping center.
%
Gumperson's Law:
 The probability of a given event occurring is inversely
 proportional to its desirability.
%
Gunter's Airborne Discoveries:
 (1)  When you are served a meal aboard an aircraft,
      the aircraft will encounter turbulence.
 (2)  The strength of the turbulence
      is directly proportional to the temperature of your coffee.
%
gurmlish, n.:
 The red warning flag at the top of a club sandwich which
 prevents the person from biting into it and puncturing the roof
 of his mouth.
  -- Rich Hall, "Sniglets"
%
guru, n.:
 A person in T-shirt and sandals who took an elevator ride with
 a senior vice-president and is ultimately responsible for the
 phone call you are about to receive from your boss.
%
guru, n:
 A computer owner who can read the manual.
%
gyroscope, n.:
 A wheel or disk mounted to spin rapidly about an axis and also
 free to rotate about one or both of two axes perpindicular to
 each other and the axis of spin so that a rotation of one of the
 two mutually perpendicular axes results from application of
 torque to the other when the wheel is spinning and so that the
 entire apparatus offers considerable opposition depending on
 the angular momentum to any torque that would change the direction
 of the axis of spin.
  -- Webster's Seventh New Collegiate Dictionary
%
H. L. Mencken's Law:
 Those who can -- do.
 Those who can't -- teach.

Martin's Extension:
 Those who cannot teach -- administrate.
%
Hacker's Law:
 The belief that enhanced understanding will necessarily stir
 a nation to action is one of mankind's oldest illusions.
%
Hacker's Quicky #313:
 Sour Cream -n- Onion Potato Chips
 Microwave Egg Roll
 Chocolate Milk
%
hacker, n.:
 A master byter.
%
hacker, n.:
 Originally, any person with a knack for coercing stubborn inanimate
 things; hence, a person with a happy knack, later contracted by the
 mythical philosopher Frisbee Frobenius to the common usage, 'hack'.
 In olden times, upon completion of some particularly atrocious body
 of coding that happened to work well, culpable programmers would gather
 in a small circle around a first edition of Knuth's Best Volume I by
 candlelight, and proceed to get very drunk while sporadically rending
 the following ditty:

  Hacker's Fight Song

  He's a Hack!  He's a Hack!
  He's a guy with the happy knack!
  Never bungles, never shirks,
  Always gets his stuff to work!

All take a drink (important!)
%
Hale Mail Rule, The:
 When you are ready to reply to a letter, you will lack at least
 one of the following:
  (a) A pen or pencil or typewriter.
  (b) Stationery.
  (c) Postage stamp.
  (d) The letter you are answering.
%
half-done, n.:
 This is the best way to eat a kosher dill -- when it's still crunchy,
 light green, yet full of garlic flavor.  The difference between this
 and the typical soggy dark green cucumber corpse is like the
 difference between life and death.

 You may find it difficult to find a good half-done kosher dill there
 in Seattle, so what you should do is take a cab out to the airport,
 fly to New York, take the JFK Express to Jay Street-Borough Hall,
 transfer to an uptown F, get off at East Broadway, walk north on
 Essex (along the park), make your first left onto Hester Street, walk
 about fifteen steps, turn ninety degrees left, and stop.  Say to the
 man, "Let me have a nice half-done."  Worth the trouble, wasn't it?
  -- Arthur Naiman, "Every Goy's Guide to Yiddish"
%
Hand, n.:
 A singular instrument worn at the end of a human arm and
 commonly thrust into somebody's pocket.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
handshaking protocol, n:
 A process employed by hostile hardware devices to initate a
 terse but civil dialogue, which, in turn, is characterized by
 occasional misunderstanding, sulking, and name-calling.
%
Hangover, n.:
 The burden of proof.
%
hangover, n.:
 The wrath of grapes.
%
Hanlon's Razor:
 Never attribute to malice that which is adequately explained
 by stupidity.
%
Hanson's Treatment of Time:
 There are never enough hours in a day, but always too many days
 before Saturday.
%
Happiness, n.:
 An agreeable sensation arising from contemplating the misery of another.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
hard, adj.:
 The quality of your own data; also how it is to believe those
 of other people.
%
Hardware, n.:
 The parts of a computer system that can be kicked.
%
Harriet's Dining Observation:
 In every restaurant, the hardness of the butter pats
 increases in direct proportion to the softness of the bread.
%
Harris's Lament:
 All the good ones are taken.
%
Harrisberger's Fourth Law of the Lab:
 Experience is directly proportional to the amount of equipment ruined.
%
Harrison's Postulate:
 For every action, there is an equal and opposite criticism.
%
Hartley's First Law:
 You can lead a horse to water, but if you can get him to float
 on his back, you've got something.
%
Hatred, n.:
 A sentiment appropriate to the occasion of another's superiority.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Hawkeye's Conclusion:
 It's not easy to play the clown when you've got to run the whole
 circus.
%
Heaven, n.:
 A place where the wicked cease from troubling you with talk of
 their personal affairs, and the good listen with attention while you
 expound your own.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
heavy, adj.:
 Seduced by the chocolate side of the force.
%
Heller's Law:
 The first myth of management is that it exists.

Johnson's Corollary:
 Nobody really knows what is going on anywhere within the
 organization.
%
Hempstone's Question:
 If you have to travel on the Titanic, why not go first class?
%
Herth's Law:
 He who turns the other cheek too far gets it in the neck.
%
Hewett's Observation:
 The rudeness of a bureaucrat is inversely proportional to his or
 her position in the governmental hierarchy and to the number of
 peers similarly engaged.
%
Hildebrant's Principle:
 If you don't know where you are going, any road will get you there.
%
Hippogriff, n.:
 An animal (now extinct) which was half horse and half griffin.
 The griffin was itself a compound creature, half lion and half eagle.
 The hippogriff was actually, therefore, only one quarter eagle, which
 is two dollars and fifty cents in gold.  The study of zoology is full
 of surprises.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
History, n.:
 Papa Hegel he say that all we learn from history is that we
 learn nothing from history.  I know people who can't even learn from
 what happened this morning.  Hegel must have been taking the long view.
  -- Chad C. Mulligan, "The Hipcrime Vocab"
%
Hitchcock's Staple Principle:
 The stapler runs out of staples only while you are trying to
 staple something.
%
Hlade's Law:
 If you have a difficult task, give it to a lazy person --
 they will find an easier way to do it.
%
Hoare's Law of Large Problems:
 Inside every large problem is a small problem struggling to get out.
%
Hoffer's Discovery:
 The grand act of a dying institution is to issue a newly
 revised, enlarged edition of the policies and procedures manual.
%
Hofstadter's Law:
 It always takes longer than you expect, even when you take
 Hofstadter's Law into account.
%
Hollerith, v.:
 What thou doest when thy phone is on the fritzeth.
%
honeymoon, n.:
 A short period of doting between dating and debting.
  -- Ray C. Bandy
%
Honorable, adj.:
 Afflicted with an impediment in one's reach.  In legislative
 bodies, it is customary to mention all members as honorable; as,
 "the honorable gentleman is a scurvy cur."
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Horner's Five Thumb Postulate:
 Experience varies directly with equipment ruined.
%
Horngren's Observation:
 Among economists, the real world is often a special case.
%
Household hint:
 If you are out of cream for your coffee, mayonnaise makes a
 dandy substitute.
%
HOW YOU CAN TELL THAT IT'S GOING TO BE A ROTTEN DAY:
 #1040 Your income tax refund cheque bounces.
%
HOW YOU CAN TELL THAT IT'S GOING TO BE A ROTTEN DAY:
 #15 Your pet rock snaps at you.
%
HOW YOU CAN TELL THAT IT'S GOING TO BE A ROTTEN DAY:
 #32: You call your answering service and they've never heard of you.
%
Howe's Law:
 Everyone has a scheme that will not work.
%
Hubbard's Law:
 Don't take life too seriously; you won't get out of it alive.
%
Hurewitz's Memory Principle:
 The chance of forgetting something is directly proportional
 to... to... uh.....
%
IBM Pollyanna Principle:
 Machines should work.  People should think.
%
IBM's original motto:
 Cogito ergo vendo; vendo ergo sum.
%
IBM:
 [International Business Machines Corp.]  Also known as Itty Bitty
 Machines or The Lawyer's Friend.  The dominant force in computer
 marketing, having supplied worldwide some 75% of all known hardware
 and 10% of all software.  To protect itself from the litigious envy
 of less successful organizations, such as the US government, IBM
 employs 68% of all known ex-Attorneys' General.
%
IBM:
 I've Been Moved
 Idiots Become Managers
 Idiots Buy More
 Impossible to Buy Machine
 Incredibly Big Machine
 Industry's Biggest Mistake
 International Brotherhood of Mercenaries
 It Boggles the Mind
 It's Better Manually
 Itty-Bitty Machines
%
IBM:
 It may be slow, but it's hard to use.
%
idiot box, n.:
 The part of the envelope that tells a person where to place the
 stamp when they can't quite figure it out for themselves.
  -- Rich Hall, "Sniglets"
%
Idiot, n.:
 A member of a large and powerful tribe whose influence in human
 affairs has always been dominant and controlling.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
idleness, n.:
 Leisure gone to seed.
%
ignisecond, n:
 The overlapping moment of time when the hand is locking the car
 door even as the brain is saying, "my keys are in there!"
  -- Rich Hall, "Sniglets"
%
ignorance, n.:
 When you don't know anything, and someone else finds out.
%
Iles's Law:
 There is always an easier way to do it.  When looking directly
 at the easy way, especially for long periods, you will not see it.
 Neither will Iles.
%
Imbesi's Law with Freeman's Extension:
 In order for something to become clean, something else must
 become dirty; but you can get everything dirty without getting
 anything clean.
%
Immutability, Three Rules of:
 (1)  If a tarpaulin can flap, it will.
 (2)  If a small boy can get dirty, he will.
 (3)  If a teenager can go out, he will.
%
Impartial, adj.:
 Unable to perceive any promise of personal advantage from
 espousing either side of a controversy or adopting either of two
 conflicting opinions.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
inbox, n.:
 A catch basin for everything you don't want to deal with, but
 are afraid to throw away.
%
incentive program, n.:
 The system of long and short-term rewards that a corporation uses
 to motivate its people.  Still, despite all the experimentation with
 profit sharing, stock options, and the like, the most effective
 incentive program to date seems to be "Do a good job and you get to
 keep it."
%
Incumbent, n.:
 Person of liveliest interest to the outcumbents.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
index, n.:
 Alphabetical list of words of no possible interest where an
 alphabetical list of subjects with references ought to be.
%
Infancy, n.:
 The period of our lives when, according to Wordsworth, "Heaven lies
 about us."  The world begins lying about us pretty soon afterward.
  -- Ambrose Bierce
%
Information Center, n.:
 A room staffed by professional computer people whose job it is to
 tell you why you cannot have the information you require.
%
Information Processing:
 What you call data processing when people are so disgusted with
 it they won't let it be discussed in their presence.
%
Ingrate, n.:
 A man who bites the hand that feeds him, and then complains of
 indigestion.
%
ink, n.:
 A villainous compound of tannogallate of iron, gum-arabic,
 and water, chiefly used to facilitate the infection of
 idiocy and promote intellectual crime.
  -- H.L. Mencken
%
innovate, v.:
 To annoy people.
%
insecurity, n.:
 Finding out that you've mispronounced for years one of your
 favorite words.

 Realizing halfway through a joke that you're telling it to
 the person who told it to you.
%
interest, n.:
 What borrowers pay, lenders receive, stockholders own, and
 burned out employees must feign.
%
Interpreter, n.:
 One who enables two persons of different languages to
 understand each other by repeating to each what it would have been to
 the interpreter's advantage for the other to have said.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
intoxicated, adj.:
 When you feel sophisticated without being able to pronounce it.
%
Iron Law of Distribution:
 Them that has, gets.
%
ISO applications:
 A solution in search of a problem!
%
Issawi's Laws of Progress:
 The Course of Progress:
  Most things get steadily worse.
 The Path of Progress:
  A shortcut is the longest distance between two points.
%
It is fruitless:
 to become lachrymose over precipitately departed lactate fluid.

 to attempt to indoctrinate a superannuated canine with
 innovative maneuvers.
%
"It's in process":
 So wrapped up in red tape that the situation is almost hopeless.
%
italic, adj:
 Slanted to the right to emphasize key phrases.  Unique to
 Western alphabets; in Eastern languages, the same phrases
 are often slanted to the left.
%
Jacquin's Postulate on Democratic Government:
 No man's life, liberty, or property are safe while the
 legislature is in session.
%
Jenkinson's Law:
 It won't work.
%
Jim Nasium's Law:
 In a large locker room with hundreds of lockers, the few people
 using the facility at any one time will all have lockers next to
 each other so that everybody is cramped.
%
job interview, n.:
 The excruciating process during which personnel officers
 separate the wheat from the chaff -- then hire the chaff.
%
job Placement, n.:
 Telling your boss what he can do with your job.
%
jogger, n.:
 An odd sort of person with a thing for pain.
%
Johnny Carson's Definition:
 The smallest interval of time known to man is that which occurs
 in Manhattan between the traffic signal turning green and the
 taxi driver behind you blowing his horn.
%
Johnson's First Law:
 When any mechanical contrivance fails, it will do so at the
 most inconvenient possible time.
%
Johnson's law:
 Systems resemble the organizations that create them.
%
Jones' First Law:
 Anyone who makes a significant contribution to any field of
 endeavor, and stays in that field long enough, becomes an
 obstruction to its progress -- in direct proportion to the
 importance of their original contribution.
%
Jones' Motto:
 Friends come and go, but enemies accumulate.
%
Jones' Second Law:
 The man who smiles when things go wrong has thought of someone
 to blame it on.
%
Juall's Law on Nice Guys:
 Nice guys don't always finish last; sometimes they don't finish.
 Sometimes they don't even get a chance to start!
%
Justice, n.:
 A decision in your favor.
%
Kafka's Law:
 In the fight between you and the world, back the world.
  -- Franz Kafka, "RS's 1974 Expectation of Days"
%
Karlson's Theorem of Snack Food Packages:
 For all P, where P is a package of snack food, P is a SINGLE-SERVING
 package of snack food.

Gibson the Cat's Corrolary:
 For all L, where L is a package of lunch meat, L is Gibson's package
 of lunch meat.
%
Katz' Law:
 Men and nations will act rationally when
 all other possibilities have been exhausted.

History teaches us that men and nations behave wisely once they have
exhausted all other alternatives.
  -- Abba Eban
%
Kaufman's First Law of Party Physics:
 Population density is inversely proportional
 to the square of the distance from the keg.
%
Kaufman's Law:
 A policy is a restrictive document to prevent a recurrence
 of a single incident, in which that incident is never mentioned.
%
Keep in mind always the four constant Laws of Frisbee:
 (1) The most powerful force in the world is that of a disc
    straining to land under a car, just out of reach (this
    force is technically termed "car suck").
 (2) Never precede any maneuver by a comment more predictive
    than "Watch this!"
 (3) The probability of a Frisbee hitting something is directly
    proportional to the cost of hitting it.  For instance, a
    Frisbee will always head directly towards a policeman or
    a little old lady rather than the beat up Chevy.
 (4) Your best throw happens when no one is watching; when the
    cute girl you've been trying to impress is watching, the
    Frisbee will invariably bounce out of your hand or hit you
    in the head and knock you silly.
%
Kennedy's Market Theorem:
 Given enough inside information and unlimited credit,
 you've got to go broke.
%
Kent's Heuristic:
 Look for it first where you'd most like to find it.
%
kern, v.:
 1. To pack type together as tightly as the kernels on an ear
 of corn.  2. In parts of Brooklyn and Queens, N.Y., a small,
 metal object used as part of the monetary system.
%
kernel, n.:
 A part of an operating system that preserves the medieval
 traditions of sorcery and black art.
%
Kettering's Observation:
 Logic is an organized way of going wrong with confidence.
%
Kime's Law for the Reward of Meekness:
 Turning the other cheek merely ensures two bruised cheeks.
%
Kin, n.:
 An affliction of the blood.
%
Kington's Law of Perforation:
 If a straight line of holes is made in a piece of paper, such
 as a sheet of stamps or a check, that line becomes the strongest
 part of the paper.
%
Kinkler's First Law:
 Responsibility always exceeds authority.

Kinkler's Second Law:
 All the easy problems have been solved.
%
Kliban's First Law of Dining:
 Never eat anything bigger than your head.
%
Kludge, n.:
 An ill-assorted collection of poorly-matching parts, forming a
 distressing whole.
  -- Jackson Granholm, "Datamation"
%
Knebel's Law:
 It is now proved beyond doubt that smoking is one of the leading
 causes of statistics.
%
knowledge, n.:
 Things you believe.
%
Kramer's Law:
 You can never tell which way the train went by looking at the tracks.
%
Krogt, n. (chemical symbol: Kr):
 The metallic silver coating found on fast-food game cards.
  -- Rich Hall, "Sniglets"
%
Labor, n.:
 One of the processes by which A acquires property for B.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Lackland's Laws:
 (1) Never be first.
 (2) Never be last.
 (3) Never volunteer for anything
%
Lactomangulation, n.:
 Manhandling the "open here" spout on a milk carton so badly
 that one has to resort to using the "illegal" side.
  -- Rich Hall, "Sniglets"
%
Langsam's Laws:
 (1) Everything depends.
 (2) Nothing is always.
 (3) Everything is sometimes.
%
Larkinson's Law:
 All laws are basically false.
%
laser, n.:
 Failed death ray.
%
Laura's Law:
 No child throws up in the bathroom.
%
Law of Communications:
 The inevitable result of improved and enlarged communications
 between different levels in a hierarchy is a vastly increased
 area of misunderstanding.
%
Law of Continuity:
 Experiments should be reproducible.  They should all fail the same way.
%
Law of Procrastination:
 Procrastination avoids boredom; one never has
 the feeling that there is nothing important to do.
%
Law of Selective Gravity:
 An object will fall so as to do the most damage.

Jenning's Corollary:
 The chance of the bread falling with the buttered side
 down is directly proportional to the cost of the carpet.

Law of the Perversity of Nature:
 You cannot determine beforehand which side of the bread to butter.
%
Law of the Jungle:
 He who hesitates is lunch.
%
Laws of Computer Programming:
 (1) Any given program, when running, is obsolete.
 (2) Any given program costs more and takes longer.
 (3) If a program is useful, it will have to be changed.
 (4) If a program is useless, it will have to be documented.
 (5) Any given program will expand to fill all available memory.
 (6) The value of a program is proportional the weight of its output.
 (7) Program complexity grows until it exceeds the capability of
  the programmer who must maintain it.
%
Laws of Serendipity:
 (1) In order to discover anything, you must be looking for something.
 (2) If you wish to make an improved product, you must already
     be engaged in making an inferior one.
%
lawsuit, n.:
 A machine which you go into as a pig and come out as a sausage.
  -- Ambrose Bierce
%
Lawyer's Rule:
 When the law is against you, argue the facts.
 When the facts are against you, argue the law.
 When both are against you, call the other lawyer names.
%
Lazlo's Chinese Relativity Axiom:
 No matter how great your triumphs or how tragic your defeats --
 approximately one billion Chinese couldn't care less.
%
learning curve, n.:
 An astonishing new theory, discovered by management consultants
 in the 1970's, asserting that the more you do something the
 quicker you can do it.
%
Lee's Law:
 Mother said there would be days like this,
 but she never said that there'd be so many!
%
Leibowitz's Rule:
 When hammering a nail, you will never hit your
 finger if you hold the hammer with both hands.
%
Lemma:  All horses are the same color.
Proof (by induction):
 Case n = 1: In a set with only one horse, it is obvious that all
 horses in that set are the same color.
 Case n = k: Suppose you have a set of k+1 horses.  Pull one of these
 horses out of the set, so that you have k horses.  Suppose that all
 of these horses are the same color.  Now put back the horse that you
 took out, and pull out a different one.  Suppose that all of the k
 horses now in the set are the same color.  Then the set of k+1 horses
 are all the same color.  We have k true => k+1 true; therefore all
 horses are the same color.
Theorem: All horses have an infinite number of legs.
Proof (by intimidation):
 Everyone would agree that all horses have an even number of legs.  It
 is also well-known that horses have forelegs in front and two legs in
 back.  4 + 2 = 6 legs, which is certainly an odd number of legs for a
 horse to have!  Now the only number that is both even and odd is
 infinity; therefore all horses have an infinite number of legs.
 However, suppose that there is a horse somewhere that does not have an
 infinite number of legs.  Well, that would be a horse of a different
 color; and by the Lemma, it doesn't exist.
%
leverage, n.:
 Even if someone doesn't care what the world thinks
 about them, they always hope their mother doesn't find out.
%
Lewis's Law of Travel:
 The first piece of luggage out of the chute doesn't belong to anyone,
 ever.
%
Liar, n.:
 A lawyer with a roving commission.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Liar:
 one who tells an unpleasant truth.
  -- Oliver Herford
%
Lie, n.:
 A very poor substitute for the truth, but the only one
 discovered to date.
%
Lieberman's Law:
 Everybody lies, but it doesn't matter since nobody listens.
%
life, n.:
 A whim of several billion cells to be you for a while.
%
life, n.:
 Learning about people the hard way -- by being one.
%
life, n.:
 That brief interlude between nothingness and eternity.
%
lighthouse, n.:
 A tall building on the seashore in which the government
 maintains a lamp and the friend of a politician.
%
like:
 When being alive at the same time is a wonderful coincidence.
%
Linus' Law:
 There is no heavier burden than a great potential.
%
lisp, v.:
 To call a spade a thpade.
%
Lockwood's Long Shot:
 The chances of getting eaten up by a lion on Main Street
 aren't one in a million, but once would be enough.
%
love,  n.:
 Love ties in a knot in the end of the rope.
%
love, n.:
 When it's growing, you don't mind watering it with a few tears.
%
love, n.:
 When you don't want someone too close--because you're very sensitive
 to pleasure.
%
love, n.:
 When you like to think of someone on days that begin with a morning.
%
love, n.:
 When, if asked to choose between your lover
 and happiness, you'd skip happiness in a heartbeat.
%
love, v.:
 I'll let you play with my life if you'll let me play with yours.
%
Lowery's Law:
 If it jams -- force it.  If it breaks, it needed replacing anyway.
%
Lubarsky's Law of Cybernetic Entomology:
 There's always one more bug.
%
Lunatic Asylum, n.:
 The place where optimism most flourishes.
%
Machine-Independent, adj.:
 Does not run on any existing machine.
%
Mad, adj.:
 Affected with a high degree of intellectual independence ...
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Madison's Inquiry:
 If you have to travel on the Titanic, why not go first class?
%
MAFIA, n:
 [Acronym for Mechanized Applications in Forced Insurance
Accounting.] An extensive network with many on-line and offshore
subsystems running under OS, DOS, and IOS.  MAFIA documentation is
rather scanty, and the MAFIA sales office exhibits that testy
reluctance to bona fide inquiries which is the hallmark of so many DP
operations.  From the little that has seeped out, it would appear that
MAFIA operates under a non-standard protocol, OMERTA, a tight-lipped
variant of SNA, in which extended handshakes also perform complex
security functions.  The known timesharing aspects of MAFIA point to a
more than usually autocratic operating system.  Screen prompts carry an
imperative, nonrefusable weighting (most menus offer simple YES/YES
options, defaulting to YES) that precludes indifference or delay.
Uniquely, all editing under MAFIA is performed centrally, using a
powerful rubout feature capable of erasing files, filors, filees, and
entire nodal aggravations.
  -- Stan Kelly-Bootle, "The Devil's DP Dictionary"
%
Magary's Principle:
 When there is a public outcry to cut deadwood and fat from any
 government bureaucracy, it is the deadwood and the fat that do
 the cutting, and the public's services are cut.
%
Magnet, n.:
 Something acted upon by magnetism.

Magnetism, n.:
 Something acting upon a magnet.

The two definition immediately foregoing are condensed from the works of
one thousand eminent scientists, who have illuminated the subject with
a great white light, to the inexpressible advancement of human knowledge.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Magnocartic, adj.:
 Any automobile that, when left unattended, attracts shopping carts.
  -- Sniglets, "Rich Hall & Friends"
%
Magpie, n.:
 A bird whose theivish disposition suggested to someone that it
 might be taught to talk.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Maier's Law:
 If the facts do not conform to the theory, they must be disposed of.
  -- N.R. Maier, "American Psychologist", March 1960

Corollaries:
 (1) The bigger the theory, the better.
 (2) The experiment may be considered a success if no more than
     50% of the observed measurements must be discarded to
     obtain a correspondence with the theory.
%
Main's Law:
 For every action there is an equal and opposite government program.
%
Maintainer's Motto:
 If we can't fix it, it ain't broke.
%
Major premise:
 Sixty men can do sixty times as much work as one man.
Minor premise:
 A man can dig a posthole in sixty seconds.
Conclusion:
 Sixty men can dig a posthole in one second.
  -- Ambrose Bierce, "The Devil's Dictionary"

Secondary Conclusion:
 Do you realize how many holes there would be if people
 would just take the time to take the dirt out of them?
%
Majority, n.:
 That quality that distinguishes a crime from a law.
%
Male, n.:
 A member of the unconsidered, or negligible sex.  The male of the
 human race is commonly known to the female as Mere Man.  The genus
 has two varieties:  good providers and bad providers.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Malek's Law:
 Any simple idea will be worded in the most complicated way.
%
malpractice, n.:
 The reason surgeons wear masks.
%
management, n.:
 The art of getting other people to do all the work.
%
manic-depressive, adj.:
 Easy glum, easy glow.
%
Manly's Maxim:
 Logic is a systematic method of coming to the wrong conclusion
 with confidence.
%
manual, n.:
 A unit of documentation.  There are always three or more on a given
 item.  One is on the shelf; someone has the others.  The information
 you need is in the others.
  -- Ray Simard
%
Mark's Dental-Chair Discovery:
 Dentists are incapable of asking questions that require a
 simple yes or no answer.
%
marriage, n.:
 An old, established institution, entered into by two people deeply
 in love and desiring to make a committment to each other expressing
 that love.  In short, committment to an institution.
%
marriage, n.:
 Convertible bonds.
%
Marriage, n.:
 The evil aye.
%
Marxist Law of Distribution of Wealth:
 Shortages will be divided equally among the peasants.
%
Maryann's Law:
 You can always find what you're not looking for.
%
Maslow's Maxim:
 If the only tool you have is a hammer, you treat everything like
 a nail.
%
Mason's First Law of Synergism:
 The one day you'd sell your soul for something, souls are a glut.
%
mathematician, n.:
 Some one who believes imaginary things appear right before your i's.
%
Matz's Law:
 A conclusion is the place where you got tired of thinking.
%
May's Law:
 The quality of correlation is inversly proportional to the density
 of control.  (The fewer the data points, the smoother the curves.)
%
McEwan's Rule of Relative Importance:
 When traveling with a herd of elephants, don't be the first to
 lie down and rest.
%
McGowan's Madison Avenue Axiom:
 If an item is advertised as "under $50", you can bet it's not $19.95.
%
Meade's Maxim:
 Always remember that you are absolutely unique, just like everyone else.
%
Meader's Law:
 Whatever happens to you, it will previously
 have happened to everyone you know, only more so.
%
meeting, n.:
 An assembly of people coming together to decide what person or
 department not represented in the room must solve a problem.
%
meetings, n.:
 A place where minutes are kept and hours are lost.
%
memo, n.:
 An interoffice communication too often written more for the benefit
 of the person who sends it than the person who receives it.
%
Mencken and Nathan's Fifteenth Law of The Average American:
 The worst actress in the company is always the manager's wife.
%
Mencken and Nathan's Ninth Law of The Average American:
 The quality of a champagne is judged by the amount of noise the
 cork makes when it is popped.
%
Mencken and Nathan's Second Law of The Average American:
 All the postmasters in small towns read all the postcards.
%
Mencken and Nathan's Sixteenth Law of The Average American:
 Milking a cow is an operation demanding a special talent that
 is possessed only by yokels, and no person born in a large city can
 never hope to acquire it.
%
Menu, n.:
 A list of dishes which the restaurant has just run out of.
%
Meskimen's Law:
 There's never time to do it right, but there's always time to
 do it over.
%
meterologist, n.:
 One who doubts the established fact that it is
 bound to rain if you forget your umbrella.
%
methionylglutaminylarginyltyrosylglutamylserylleucylphenylalanylalanylglutamin-
ylleucyllysylglutamylarginyllysylglutamylglycylalanylphenylalanylvalylprolyl-
phenylalanylvalylthreonylleucylglycylaspartylprolylglycylisoleucylglutamylglu-
taminylserylleucyllysylisoleucylaspartylthreonylleucylisoleucylglutamylalanyl-
glycylalanylaspartylalanylleucylglutamylleucylglycylisoleucylprolylphenylala-
nylserylaspartylprolylleucylalanylaspartylglycylprolylthreonylisoleucylgluta-
minylasparaginylalanylthreonylleucylarginylalanylphenylalanylalanylalanylgly-
cylvalylthreonylprolylalanylglutaminylcysteinylphenylalanylglutamylmethionyl-
leucylalanylleucylisoleucylarginylglutaminyllysylhistidylprolylthreonylisoleu-
cylprolylisoleucylglycylleucylleucylmethionyltyrosylalanylasparaginylleucylva-
lylphenylalanylasparaginyllysylglycylisoleucylaspartylglutamylphenylalanyltyro-
sylalanylglutaminylcysteinylglutamyllysylvalylglycylvalylaspartylserylvalylleu-
cylvalylalanylaspartylvalylprolylvalylglutaminylglutamylserylalanylprolylphe-
nylalanylarginylglutaminylalanylalanylleucylarginylhistidylasparaginylvalylala-
nylprolylisoleucylphenylalanylisoleucylcysteinylprolylprolylaspartylalanylas-
partylaspartylaspartylleucylleucylarginylglutaminylisoleucylalanylseryltyrosyl-
glycylarginylglycyltyrosylthreonyltyrosylleucylleucylserylarginylalanylglycyl-
valylthreonylglycylalanylglutamylasparaginylarginylalanylalanylleucylprolylleu-
cylasparaginylhistidylleucylvalylalanyllysylleucyllysylglutamyltyrosylasparagi-
nylalanylalanylprolylprolylleucylglutaminylglycylphenylalanylglycylisoleucylse-
rylalanylprolylaspartylglutaminylvalyllysylalanylalanylisoleucylaspartylalanyl-
glycylalanylalanylglycylalanylisoleucylserylglycylserylalanylisoleucylvalylly-
sylisoleucylisoleucylglutamylglutaminylhistidylasparaginylisoleucylglutamylpro-
lylglutamyllysylmethionylleucylalanylalanylleucyllysylvalylphenylalanylvalyl-
glutaminylprolylmethionyllysylalanylalanylthreonylarginylserine, n.:
 The chemical name for tryptophan synthetase A protein, a
 1,913-letter enzyme with 267 amino acids.
  -- Mrs. Byrne's Dictionary of Unusual, Obscure, and
     Preposterous Words
%
Micro Credo:
 Never trust a computer bigger than you can lift.
%
micro:
 Thinker toys.
%
Miksch's Law:
 If a string has one end, then it has another end.
%
Miller's Slogan:
 Lose a few, lose a few.
%
millihelen, n.:
 The amount of beauty required to launch one ship.
%
Minicomputer:
 A computer that can be afforded on the budget of a middle-level manager.
%
MIPS:
 Meaningless Indicator of Processor Speed
%
Misfortune, n.:
 The kind of fortune that never misses.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
MIT:
 The Georgia Tech of the North
%
Mitchell's Law of Committees:
 Any simple problem can be made insoluble if enough meetings are
 held to discuss it.
%
mittsquinter, adj.:
 A ballplayer who looks into his glove after missing the ball, as
 if, somehow, the cause of the error lies there.
  -- "Sniglets", Rich Hall & Friends
%
Mix's Law:
 There is nothing more permanent than a temporary building.
 There is nothing more permanent than a temporary tax.
%
mixed emotions:
 Watching a bus-load of lawyers plunge off a cliff.
 With five empty seats.
%
mixed emotions:
 Watching your mother-in-law back off a cliff...
 in your brand new Mercedes.
%
modem, adj.:
 Up-to-date, new-fangled, as in "Thoroughly Modem Millie."  An
 unfortunate byproduct of kerning.

 [That's sic!]
%
modesty, n.:
 Being comfortable that others will discover your greatness.
%
Modesty:
 The gentle art of enhancing your charm by pretending not to be
 aware of it.
  -- Oliver Herford
%
Molecule, n.:
 The ultimate, indivisible unit of matter.  It is distinguished
 from the corpuscle, also the ultimate, indivisible unit of matter, by a
 closer resemblance to the atom, also the ultimate, indivisible unit of
 matter ... The ion differs from the molecule, the corpuscle and the
 atom in that it is an ion ...
 -- Ambrose Bierce, "The Devil's Dictionary"
%
Mollison's Bureaucracy Hypothesis:
 If an idea can survive a bureaucratic review and be implemented
 it wasn't worth doing.
%
momentum, n.:
 What you give a person when they are going away.
%
Moon, n.:
 1. A celestial object whose phase is very important to hackers.  See
 PHASE OF THE MOON.  2. Dave Moon (MOON@MC).
%
Moore's Constant:
 Everybody sets out to do something, and everybody
 does something, but no one does what he sets out to do.
%
mophobia, n.:
 Fear of being verbally abused by a Mississippian.
%
Morton's Law:
 If rats are experimented upon, they will develop cancer.
%
Mosher's Law of Software Engineering:
 Don't worry if it doesn't work right.  If everything did, you'd
 be out of a job.
%
Mr. Cole's Axiom:
 The sum of the intelligence on the planet is a constant; the
 population is growing.
%
mummy, n.:
 An Egyptian who was pressed for time.
%
Murphy's Law of Research:
 Enough research will tend to support your theory.
%
Murphy's Laws:
 (1) If anything can go wrong, it will.
 (2) Nothing is as easy as it looks.
 (3) Everything takes longer than you think it will.
%
Murray's Rule:
 Any country with "democratic" in the title isn't.
%
Mustgo, n.:
 Any item of food that has been sitting in the refrigerator so
 long it has become a science project.
  -- Sniglets, "Rich Hall & Friends"
%
My father taught me three things:
 (1) Never mix whiskey with anything but water.
 (2) Never try to draw to an inside straight.
 (3) Never discuss business with anyone who refuses to give his name.
%
Nachman's Rule:
 When it comes to foreign food, the less authentic the better.
  -- Gerald Nachman
%
narcolepulacyi, n.:
 The contagious action of yawning, causing everyone in sight
 to also yawn.
  -- "Sniglets", Rich Hall & Friends
%
nerd pack, n.:
 Plastic pouch worn in breast pocket to keep pens from soiling
 clothes.  Nerd's position in engineering hierarchy can be measured
 by number of pens, grease pencils, and rulers bristling in his pack.
%
neutron bomb, n.:
 An explosive device of limited military value because, as
 it only destroys people without destroying property, it
 must be used in conjunction with bombs that destroy property.
%
new, adj.:
 Different color from previous model.
%
Newlan's Truism:
 An "acceptable" level of unemployment means that the
 government economist to whom it is acceptable still has a job.
%
Newman's Discovery:
 Your best dreams may not come true; fortunately, neither will
 your worst dreams.
%
Newton's Law of Gravitation:
 What goes up must come down.  But don't expect it to come down where
 you can find it.  Murphy's Law applies to Newton's.
%
Newton's Little-Known Seventh Law:
 A bird in the hand is safer than one overhead.
%
Nick the Greek's Law of Life:
 All things considered, life is 9 to 5 against.
%
Ninety-Ninety Rule of Project Schedules:
 The first ninety percent of the task takes ninety percent of
 the time, and the last ten percent takes the other ninety percent.
%
no brainer:
 A decision which, viewed through the retrospectoscope,
 is "obvious" to those who failed to make it originally.
%
no maintenance:
 Impossible to fix.
%
nolo contendere:
 A legal term meaning: "I didn't do it, judge, and I'll never do
 it again."
%
nominal egg:
 New Yorkerese for expensive.
%
Non-Reciprocal Laws of Expectations:
 Negative expectations yield negative results.
 Positive expectations yield negative results.
%
Nouvelle cuisine, n.:
 French for "not enough food".

Continental breakfast, n.:
 English for "not enough food".

Tapas, n.:
 Spanish for "not enough food".

Dim Sum, n.:
 Chinese for more food than you've ever seen in your entire life.
%
November, n.:
 The eleventh twelfth of a weariness.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Novinson's Revolutionary Discovery:
 When comes the revolution, things will be different --
 not better, just different.
%
Nowlan's Theory:
 He who hesitates is not only lost, but several miles from
 the next freeway exit.
%
Nusbaum's Rule:
 The more pretentious the corporate name, the smaller the
 organization.  (For instance, the Murphy Center for the
 Codification of Human and Organizational Law, contrasted
 to IBM, GM, and AT&T.)
%
O'Brian's Law:
 Everything is always done for the wrong reasons.
%
O'Reilly's Law of the Kitchen:
 Cleanliness is next to impossible
%
O'Toole's commentary on Murphy's Law:
 Murphy was an optimist.
%
Occam's eraser:
 The philosophical principle that even the simplest
 solution is bound to have something wrong with it.
%
Office Automation:
 The use of computers to improve efficiency in the office
 by removing anyone you would want to talk with over coffee.
%
Official Project Stages:
 (1) Uncritical Acceptance
 (2) Wild Enthusiasm
 (3) Dejected Disillusionment
 (4) Total Confusion
 (5) Search for the Guilty
 (6) Punishment of the Innocent
 (7) Promotion of the Non-participants
%
Ogden's Law:
 The sooner you fall behind, the more time you have to catch up.
%
Old Japanese proverb:
 There are two kinds of fools -- those who never climb Mt. Fuji,
 and those who climb it twice.
%
Old timer, n.:
 One who remembers when charity was a virtue and not an organization.
%
Oliver's Law:
 Experience is something you don't get until just after you need it.
%
Olmstead's Law:
 After all is said and done, a hell of a lot more is said than done.
%
omnibiblious, adj.:
 Indifferent to type of drink.  Ex: "Oh, you can get me anything.
 I'm omnibiblious."
%
On ability:
 A dwarf is small, even if he stands on a mountain top;
 a colossus keeps his height, even if he stands in a well.
  -- Lucius Annaeus Seneca, 4BC - 65AD
%
On the subject of C program indentation:
 "In My Egotistical Opinion, most people's C programs should be
 indented six feet downward and covered with dirt."
  -- Blair P. Houghton
%
On-line, adj.:
 The idea that a human being should always be accessible to a computer.
%
Once, adv.:
 Enough.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
One Page Principle:
 A specification that will not fit on one page of 8.5x11 inch
 paper cannot be understood.
  -- Mark Ardis
%
"One size fits all":
 Doesn't fit anyone.
%
One-Shot Case Study, n.:
 The scientific equivalent of the four-leaf clover, from which it is
 concluded all clovers possess four leaves and are sometimes green.
%
Optimism, n.:
 The belief that everything is beautiful, including what is ugly, good,
 bad, and everything right that is wrong.  It is held with greatest
 tenacity by those accustomed to falling into adversity, and most
 acceptably expounded with the grin that apes a smile.  Being a blind
 faith, it is inaccessible to the light of disproof -- an intellectual
 disorder, yielding to no treatment but death.  It is hereditary, but
 not contagious.
%
optimist, n.:
 A proponent of the belief that black is white.

 A pessimist asked God for relief.
 "Ah, you wish me to restore your hope and cheerfulness," said God.
 "No," replied the petitioner, "I wish you to create something that
would justify them."
 "The world is all created," said God, "but you have overlooked
something -- the mortality of the optimist."
  -- Ambrose Bierce, "The Devil's Dictionary"
%
optimist, n:
 A bagpiper with a beeper.
%
Oregano, n.:
 The ancient Italian art of pizza folding.
%
Osborn's Law:
 Variables won't; constants aren't.
%
Ozman's Laws:
 (1)  If someone says he will do something "without fail," he won't.
 (2)  The more people talk on the phone, the less money they make.
 (3)  People who go to conferences are the ones who shouldn't.
 (4)  Pizza always burns the roof of your mouth.
%
pain, n.:
 One thing, at least it proves that you're alive!
%
Painting, n.:
 The art of protecting flat surfaces from the weather, and
 exposing them to the critic.
  -- Ambrose Bierce
%
Pandora's Rule:
 Never open a box you didn't close.
%
Paprika Measure:
 2 dashes    ==  1smidgen
 2 smidgens  ==  1 pinch
 3 pinches   ==  1 soupcon
 2 soupcons  ==  2 much paprika
%
paranoia, n.:
 A healthy understanding of the way the universe works.
%
Pardo's First Postulate:
 Anything good in life is either illegal, immoral, or fattening.

Arnold's Addendum:
 Everything else causes cancer in rats.
%
Parkinson's Fifth Law:
 If there is a way to delay in important decision, the good
 bureaucracy, public or private, will find it.
%
Parkinson's Fourth Law:
 The number of people in any working group tends to increase
 regardless of the amount of work to be done.
%
party, n.:
 A gathering where you meet people who drink
 so much you can't even remember their names.
%
Pascal Users:
 The Pascal system will be replaced next Tuesday by Cobol.
 Please modify your programs accordingly.
%
Pascal Users:
 To show respect for the 313th anniversary (tomorrow) of the
 death of Blaise Pascal, your programs will be run at half speed.
%
Pascal:
 A programming language named after a man who would turn over
 in his grave if he knew about it.
  -- Datamation, January 15, 1984
%
Password:
%
Patageometry, n.:
 The study of those mathematical properties that are invariant
 under brain transplants.
%
patent:
 A method of publicizing inventions so others can copy them.
%
Paul's Law:
 In America, it's not how much an item costs, it's how much you save.
%
Paul's Law:
 You can't fall off the floor.
%
paycheck:
 The weekly $5.27 that remains after deductions for federal
 withholding, state withholding, city withholding, FICA,
 medical/dental, long-term disability, unemployment insurance,
 Christmas Club, and payroll savings plan contributions.
%
Peace, n.:
 In international affairs, a period of cheating between two
 periods of fighting.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Pecor's Health-Food Principle:
 Never eat rutabaga on any day of the week that has a "y" in it.
%
Pedaeration, n.:
 The perfect body heat achieved by having one leg under the
 sheet and one hanging off the edge of the bed.
  -- Rich Hall, "Sniglets"
%
pediddel:
 A car with only one working headlight.
  -- "Sniglets", Rich Hall & Friends
%
Peers's Law:
 The solution to a problem changes the nature of the problem.
%
Penguin Trivia #46:
 Animals who are not penguins can only wish they were.
  -- Chicago Reader 10/15/82
%
pension:
 A federally insured chain letter.
%
People's Action Rules:
 (1) Some people who can, shouldn't.
 (2) Some people who should, won't.
 (3) Some people who shouldn't, will.
 (4) Some people who can't, will try, regardless.
 (5) Some people who shouldn't, but try, will then blame others.
%
perfect guest:
 One who makes his host feel at home.
%
Performance:
 A statement of the speed at which a computer system works.  Or
 rather, might work under certain circumstances.  Or was rumored
 to be working over in Jersey about a month ago.
%
pessimist:
 A man who spends all his time worrying about how he can keep the
 wolf from the door.

optimist:
 A man who refuses to see the wolf until he seizes the seat of
 his pants.

opportunist:
 A man who invites the wolf in and appears the next day in a fur coat.
%
Peter's Law of Substitution:
 Look after the molehills, and the
 mountains will look after themselves.

Peter's Principle of Success:
 Get up one time more than you're knocked down.

%
Peterson's Admonition:
 When you think you're going down for the third time --
 just remember that you may have counted wrong.
%
Peterson's Rules:
 (1) Trucks that overturn on freeways are filled with something sticky.
 (2) No cute baby in a carriage is ever a girl when called one.
 (3) Things that tick are not always clocks.
 (4) Suicide only works when you're bluffing.
%
petribar:
 Any sun-bleached prehistoric candy that has been sitting in
 the window of a vending machine too long.
  -- Rich Hall, "Sniglets"
%
 Phases of a Project:
(1) Exultation.
(2) Disenchantment.
(3) Confusion.
(4) Search for the Guilty.
(5) Punishment for the Innocent.
(6) Distinction for the Uninvolved.
%
philosophy:
 The ability to bear with calmness the misfortunes of our friends.
%
philosophy:
 Unintelligible answers to insoluble problems.
%
phosflink:
 To flick a bulb on and off when it burns out (as if, somehow, that
 will bring it back to life).
  -- "Sniglets", Rich Hall & Friends
%
Pickle's Law:
 If Congress must do a painful thing,
 the thing must be done in an odd-number year.
%
pixel, n.:
 A mischievous, magical spirit associated with screen displays.
 The computer industry has frequently borrowed from mythology:
 Witness the sprites in computer graphics, the demons in artificial
 intelligence, and the trolls in the marketing department.
%
Please take note:
%
Pohl's law:
 Nothing is so good that somebody, somewhere, will not hate it.
%
poisoned coffee, n.:
 Grounds for divorce.
%
politics, n.:
 A strife of interests masquerading as a contest of principles.
 The conduct of public affairs for private advantage.
  -- Ambrose Bierce
%
Pollyanna's Educational Constant:
 The hyperactive child is never absent.
%
polygon:
 Dead parrot.
%
Poorman's Rule:
 When you pull a plastic garbage bag from its handy dispenser package,
 you always get hold of the closed end and try to pull it open.
%
Portable, adj.:
 Survives system reboot.
%
Positive, adj.:
 Mistaken at the top of one's voice.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
poverty, n.:
 An unfortunate state that persists as long
 as anyone lacks anything he would like to have.
%
Power, n.:
 The only narcotic regulated by the SEC instead of the FDA.
%
prairies, n.:
 Vast plains covered by treeless forests.
%
Prejudice:
 A vagrant opinion without visible means of support.
  -- Ambrose Bierce
%
Preudhomme's Law of Window Cleaning:
 It's on the other side.
%
Price's Advice:
 It's all a game -- play it to have fun.
%
Priority:
 A statement of the importance of a user or a program.  Often
 expressed as a relative priority, indicating that the user doesn't
 care when the work is completed so long as he is treated less
 badly than someone else.
%
problem drinker, n.:
 A man who never buys.
%
program, n.:
 A magic spell cast over a computer allowing it to turn one's input
 into error messages.  tr.v. To engage in a pastime similar to banging
 one's head against a wall, but with fewer opportunities for reward.
%
program, n.:
 Any task that can't be completed in one telephone call or one
 day.  Once a task is defined as a program ("training program,"
 "sales program," or "marketing program"), its implementation
 always justifies hiring at least three more people.
%
Programming Department:
 Mistakes made while you wait.
%
progress, n.:
 Medieval man thought disease was caused by invisible demons
 invading the body and taking possession of it.

 Modern man knows disease is caused by microscopic bacteria
 and viruses invading the body and causing it to malfunction.
%
Proof techniques #2: Proof by Oddity.
 SAMPLE: To prove that horses have an infinite number of legs.
(1) Horses have an even number of legs.
(2) They have two legs in back and fore legs in front.
(3) This makes a total of six legs, which certainly is an odd number of
    legs for a horse.
(4) But the only number that is both odd and even is infinity.
(5) Therefore, horses must have an infinite number of legs.

Topics is be covered in future issues include proof by:
 Intimidation
 Gesticulation (handwaving)
 "Try it; it works"
 Constipation (I was just sitting there and ...)
 Blatant assertion
 Changing all the 2's to n's
 Mutual consent
 Lack of a counterexample, and
 "It stands to reason"
%
prototype, n.:
 First stage in the life cycle of a computer product, followed by
 pre-alpha, alpha, beta, release version, corrected release version,
 upgrade, corrected upgrade, etc.  Unlike its successors, the
 prototype is not expected to work.
%
Pryor's Observation:
 How long you live has nothing to do
 with how long you are going to be dead.
%
Pudder's Law:
 Anything that begins well will end badly.
 (Note: The converse of Pudder's law is not true.)
%
purpitation, n.:
 To take something off the grocery shelf, decide you
 don't want it, and then put it in another section.
  -- "Sniglets", Rich Hall & Friends
%
Putt's Law:
 Technology is dominated by two types of people:
  Those who understand what they do not manage.
  Those who manage what they do not understand.
%
QOTD:
  "It's not the despair... I can stand the despair.  It's the hope."
%
QOTD:
 "A child of 5 could understand this!  Fetch me a child of 5."
%
QOTD:
 "A university faculty is 500 egotists with a common parking problem."
%
QOTD:
 "Do you smell something burning or is it me?"
  -- Joan of Arc
%
QOTD:
 "Don't let your mind wander -- it's too little to be let out alone."
%
QOTD:
 "East is east... and let's keep it that way."
%
QOTD:
 "Even the Statue of Liberty shaves her pits."
%
QOTD:
 "Every morning I read the obituaries; if my name's not there,
 I go to work."
%
QOTD:
 "Everything I am today I owe to people, whom it is now
 to late to punish."
%
QOTD:
 "He eats like a bird... five times his own weight each day."
%
QOTD:
 "He's on the same bus, but he's sure as hell got a different
 ticket."
%
QOTD:
 "I ain't broke, but I'm badly bent."
%
QOTD:
 "I am not sure what this is, but an 'F' would only dignify it."
%
QOTD:
 "I don't think they could put him in a mental hospital.  On the
 other hand, if he were already in, I don't think they'd let him out."
%
QOTD:
 "I drive my car quietly, for it goes without saying."
%
QOTD:
 "I haven't come far enough, and don't call me baby."
%
QOTD:
 "I may not be able to walk, but I drive from the sitting position."
%
QOTD:
 "I never met a man I couldn't drink handsome."
%
QOTD:
 "I only touch base with reality on an as-needed basis!"
%
QOTD:
 "I sprinkled some baking powder over a couple of potatoes, but it
 didn't work."
%
QOTD:
 "I thought I saw a unicorn on the way over, but it was just a
 horse with one of the horns broken off."
%
QOTD:
 "I tried buying a goat instead of a lawn tractor; had to return
 it though.  Couldn't figure out a way to connect the snow blower."
%
QOTD:
 "I used to be an idealist, but I got mugged by reality."
%
QOTD:
 "I used to be lost in the shuffle, now I just shuffle along with
 the lost."
%
QOTD:
 "I used to get high on life but lately I've built up a resistance."
%
QOTD:
 "I used to go to UCLA, but then my Dad got a job."
%
QOTD:
 "I used to jog, but the ice kept bouncing out of my glass."
%
QOTD:
 "I won't say he's untruthful, but his wife has to call the
 dog for dinner."
%
QOTD:
 "I'd never marry a woman who didn't like pizza... I might play
 golf with her, but I wouldn't marry her!"
%
QOTD:
 "I'll listen to reason when it comes out on CD."
%
QOTD:
 "I'm just a boy named 'su'..."
%
QOTD:
 "I'm not really for apathy, but I'm not against it either..."
%
QOTD:
 "I'm on a seafood diet -- I see food and I eat it."
%
QOTD:
 "I've always wanted to work in the Federal Mint.  And then go on
 strike.  To make less money."
%
QOTD:
 "I've got one last thing to say before I go; give me back
 all of my stuff."
%
QOTD:
 "I've just learned about his illness.  Let's hope it's nothing
 trivial."
%
QOTD:
 "If he learns from his mistakes, pretty soon he'll know everything."
%
QOTD:
 "If I could walk that way, I wouldn't need the cologne, now would I?"
%
QOTD:
 "If I'm what I eat, I'm a chocolate chip cookie."
%
QOTD:
 "If you keep an open mind people will throw a lot of garbage in it."
%
QOTD:
 "In the shopping mall of the mind, he's in the toy department."
%
QOTD:
 "It seems to me that your antenna doesn't bring in too many
 stations anymore."
%
QOTD:
 "It was so cold last winter that I saw a lawyer with his
 hands in his own pockets."
%
QOTD:
 "It wouldn't have been anything, even if it were gonna be a thing."
%
QOTD:
 "It's a cold bowl of chili, when love don't work out."
%
QOTD:
 "It's been Monday all week today."
%
QOTD:
 "It's been real and it's been fun, but it hasn't been real fun."
%
QOTD:
 "It's hard to tell whether he has an ace up his sleeve or if
 the ace is missing from his deck altogether."
%
QOTD:
 "It's sort of a threat, you see.  I've never been very good at
 them myself, but I'm told they can be very effective."
%
QOTD:
 "Just how much can I get away with and still go to heaven?"
%
QOTD:
 "Lack of planning on your part doesn't consitute an emergency
 on my part."
%
QOTD:
 "Like this rose, our love will wilt and die."
%
QOTD:
 "My life is a soap opera, but who gets the movie rights?"
%
QOTD:
 "My shampoo lasts longer than my relationships."
%
QOTD:
 "Of course it's the murder weapon.  Who would frame someone with
 a fake?"
%
QOTD:
 "Of course there's no reason for it, it's just our policy."
%
QOTD:
 "Oh, no, no...  I'm not beautiful.  Just very, very pretty."
%
QOTD:
 "Our parents were never our age."
%
QOTD:
 "Overweight is when you step on your dog's tail and it dies."
%
QOTD:
 "Say, you look pretty athletic.  What say we put a pair of tennis
 shoes on you and run you into the wall?"
%
QOTD:
 "She's about as smart as bait."
%
QOTD:
 "Sure, I turned down a drink once.  Didn't understand the question."
%
QOTD:
 "The baby was so ugly they had to hang a pork chop around its
 neck to get the dog to play with it."
%
QOTD:
 "The elder gods went to Suggoth and all I got was this lousy T-shirt."
%
QOTD:
 "There may be no excuse for laziness, but I'm sure looking."
%
QOTD:
 "This is a one line proof... if we start sufficiently far to the
 left."
%
QOTD:
 "Unlucky?  If I bought a pumpkin farm, they'd cancel Halloween."
%
QOTD:
 "What do you mean, you had the dog fixed?   Just what made you
 think he was broken!"
%
QOTD:
 "What I like most about myself is that I'm so understanding
 when I mess things up."
%
QOTD:
 "What women and psychologists call `dropping your armor', we call
 "baring your neck."
%
QOTD:
 "When she hauled ass, it took three trips."
%
QOTD:
 "Who?  Me?  No, no, NO!!  But I do sell rugs."
%
QOTD:
 "Wouldn't it be wonderful if real life supported control-Z?"
%
QOTD:
 "You want me to put *holes* in my ears and hang things from them?
 How...  tribal."
%
QOTD:
 "You're so dumb you don't even have wisdom teeth."
%
QOTD:
 All I want is a little more than I'll ever get.
%
QOTD:
 All I want is more than my fair share.
%
QOTD:
 Flash!  Flash!  I love you! ...but we only have fourteen hours to
 save the earth!
%
QOTD:
 How can I miss you if you won't go away?
%
QOTD:
 I looked out my window, and saw Kyle Pettys' car upside down,
 then I thought 'One of us is in real trouble'.
  -- Davey Allison, on a 150 m.p.h. crash
%
QOTD:
 I love your outfit, does it come in your size?
%
QOTD:
 I opened Pandora's box, let the cat out of the bag and put the
 ball in their court.
  -- Hon. J. Hacker (The Ministry of Administrative Affairs)
%
QOTD:
 I'm not a nerd -- I'm "socially challenged".
%
QOTD:
 I'm not bald -- I'm "hair challenged".

 [I thought that was "differently haired". Ed.]
%
QOTD:
 I've heard about civil Engineers, but I've never met one.
%
QOTD:
 If it's too loud, you're too old.
%
QOTD:
 If you're looking for trouble, I can offer you a wide selection.
%
QOTD:
 Ludwig Boltzmann, who spend much of his life studying statistical
 mechanics died in 1906 by his own hand.  Paul Ehrenfest, carrying
 on the work, died similarly in 1933.  Now it is our turn.
  -- Goodstein, States of Matter
%
QOTD:
 Money isn't everything, but at least it keeps the kids in touch.
%
QOTD:
 My mother was the travel agent for guilt trips.
%
QOTD:
 On a scale of 1 to 10 I'd say...  oh, somewhere in there.
%
QOTD:
 Sacred cows make great hamburgers.
%
QOTD:
 Silence is the only virtue he has left.
%
QOTD:
 Some people have one of those days.  I've had one of those lives.
%
QOTD:
 Talent does what it can, genius what it must.
 I do what I get paid to do.
%
QOTD:
 Talk about willing people... over half of them are willing to work
 and the others are more than willing to watch them.
%
QOTD:
 The forest may be quiet, but that doesn't mean
 the snakes have gone away.
%
QOTD:
 The only easy way to tell a hamster from a gerbil is that the
 gerbil has more dark meat.
%
QOTD:
 Y'know how s'm people treat th'r body like a TEMPLE?
 Well, I treat mine like 'n AMUSEMENT PARK...  S'great...
%
Quality control, n.:
 Assuring that the quality of a product does not get out of hand
 and add to the cost of its manufacture or design.
%
Quality Control, n.:
 The process of testing one out of every 1,000 units coming off
 a production line to make sure that at least one out of 100 works.
%
quark:
 The sound made by a well bred duck.
%
Quigley's Law:
 Whoever has any authority over you, no matter how small, will
 atttempt to use it.
%
QWERT (kwirt) n. [MW < OW qwertyuiop, a thirteenth]   1. a unit of weight
equal to 13 poiuyt  avoirdupois  (or 1.69 kiloliks), commonly used in
structural engineering  2. [Colloq.] one thirteenth the load that a fully
grown sligo can carry.  3. [Anat.] a painful  irritation  of  the dermis
in the region of the anus  4. [Slang] person who excites in others the
symptoms of a qwert.
  -- Webster's Middle World Dictionary, 4th ed.
%
Ralph's Observation:
 It is a mistake to let any mechanical object realise that you
 are in a hurry.
%
Random, n.:
 As in number, predictable.  As in memory access, unpredictable.
%
Ray's Rule of Precision:
 Measure with a micrometer.  Mark with chalk.  Cut with an axe.
%
Re: Graphics:
 A picture is worth 10K words -- but only those to describe
 the picture.  Hardly any sets of 10K words can be adequately
 described with pictures.
%
Real Time, adj.:
 Here and now, as opposed to fake time, which only occurs there and then.
%
Real World, The, n.:
 1. In programming, those institutions at which programming may
be used in the same sentence as FORTRAN, COBOL, RPG, IBM, etc.  2. To
programmers, the location of non-programmers and activities not related
to programming.  3. A universe in which the standard dress is shirt and
tie and in which a person's working hours are defined as 9 to 5.  4.
The location of the status quo.  5. Anywhere outside a university.
"Poor fellow, he's left MIT and gone into the real world."  Used
pejoratively by those not in residence there.  In conversation, talking
of someone who has entered the real world is not unlike talking about a
deceased person.
%
Reappraisal, n.:
 An abrupt change of mind after being found out.
%
Reception area, n.:
 The purgatory where office visitors are condemned to spend
 innumerable hours reading dog-eared back issues of trade
 magazines like Modern Plastics, Chain Saw Age, and Chicken World,
 while the receptionist blithely reads her own trade magazine --
 Cosmopolitan.
%
Recursion n.:
 See Recursion.
  -- Random Shack Data Processing Dictionary
%
Reformed, n.:
 A synagogue that closes for the Jewish holidays.
%
Regression analysis:
 Mathematical techniques for trying to understand why things are
 getting worse.
%
Reichel's Law:
 A body on vacation tends to remain on vacation unless acted upon by
 an outside force.
%
Reisner's Rule of Conceptual Inertia:
 If you think big enough, you'll never have to do it.
%
Reliable source, n.:
 The guy you just met.
%
Renning's Maxim:
 Man is the highest animal.  Man does the classifying.
%
Reporter, n.:
 A writer who guesses his way to the truth and dispels it with a
 tempest of words.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Reputation, adj.:
 What others are not thinking about you.
%
Research, n.:
 Consider Columbus:
 He didn't know where he was going.
 When he got there he didn't know where he was.
 When he got back he didn't know where he had been.
 And he did it all on someone else's money.
%
Responsibility:
 Everyone says that having power is a great responsibility.  This is
a lot of bunk.  Responsibility is when someone can blame you if something
goes wrong.  When you have power you are surrounded by people whose job it
is to take the blame for your mistakes.  If they're smart, that is.
  -- Cerebus, "On Governing"
%
Revolution, n.:
 A form of government abroad.
%
Revolution, n.:
 In politics, an abrupt change in the form of misgovernment.
  -- Ambrose Bierce
%
revolutionary, adj.:
 Repackaged.
%
Rhode's Law:
 When any principle, law, tenet, probability, happening, circumstance,
 or result can in no way be directly, indirectly, empirically, or
 circuitously proven, derived, implied, inferred, induced, deducted,
 estimated, or scientifically guessed, it will always for the purpose
 of convenience, expediency, political advantage, material gain, or
 personal comfort, or any combination of the above, or none of the
 above, be unilaterally and unequivocally assumed, proclaimed, and
 adhered to as absolute truth to be undeniably, universally, immutably,
 and infinitely so, until such time as it becomes advantageous to
 assume otherwise, maybe.
%
Ritchie's Rule:
 (1) Everything has some value -- if you use the right currency.
 (2) Paint splashes last longer than the paint job.
 (3) Search and ye shall find -- but make sure it was lost.
%
Robot, n.:
 University administrator.
%
Robustness, adj.:
 Never having to say you're sorry.
%
Rocky's Lemma of Innovation Prevention:
 Unless the results are known in advance, funding agencies will
 reject the proposal.
%
Rudd's Discovery:
 You know that any senator or congressman could go home and make
 $300,000 to $400,000, but they don't.  Why?  Because they can
 stay in Washington and make it there.
%
Rudin's Law:
 If there is a wrong way to do something, most people will
 do it every time.

Rudin's Second Law:
 In a crisis that forces a choice to be made among alternative
 courses of action, people tend to choose the worst possible
 course.
%
rugged, adj.:
 Too heavy to lift.
%
Rule #1:
 The Boss is always right.

Rule #2:
 If the Boss is wrong, see Rule #1.
%
Rule of Creative Research:
 (1) Never draw what you can copy.
 (2) Never copy what you can trace.
 (3) Never trace what you can cut out and paste down.
%
Rule of Defactualization:
 Information deteriorates upward through bureaucracies.
%
Rule of Feline Frustration:
 When your cat has fallen asleep on your lap and looks utterly
 content and adorable, you will suddenly have to go to the
 bathroom.
%
Rule of the Great:
 When people you greatly admire appear to be thinking deep
 thoughts, they probably are thinking about lunch.
%
Rules for Academic Deans:
 (1)  HIDE!!!!
 (2)  If they find you, LIE!!!!
  -- Father Damian C. Fandal
%
Rules for driving in New York:
 (1) Anything done while honking your horn is legal.
 (2) You may park anywhere if you turn your four-way flashers on.
 (3) A red light means the next six cars may go through the
     intersection.
%
Rules for Writers:
 Avoid run-on sentences they are hard to read.  Don't use no double
negatives.  Use the semicolon properly, always use it where it is appropriate;
and never where it isn't.  Reserve the apostrophe for it's proper use and
omit it when its not needed.  No sentence fragments. Avoid commas, that are
unnecessary.  Eschew dialect, irregardless.  And don't start a sentence with
a conjunction.  Hyphenate between sy-llables and avoid un-necessary hyphens.
Write all adverbial forms correct.  Don't use contractions in formal writing.
Writing carefully, dangling participles must be avoided.  It is incumbent on
us to avoid archaisms.  Steer clear of incorrect forms of verbs that have
snuck in the language.  Never, ever use repetitive redundancies.  If I've
told you once, I've told you a thousand times, resist hyperbole.  Also,
avoid awkward or affected alliteration.  Don't string too many prepositional
phrases together unless you are walking through the valley of the shadow of
death.  "Avoid overuse of 'quotation "marks."'"
%
Rune's Rule:
 If you don't care where you are, you ain't lost.
%
Ryan's Law:
 Make three correct guesses consecutively
 and you will establish yourself as an expert.
%
Sacher's Observation:
 Some people grow with responsibility -- others merely swell.
%
Satellite Safety Tip #14:
 If you see a bright streak in the sky coming at you, duck.
%
Sattinger's Law:
 It works better if you plug it in.
%
Savage's Law of Expediency:
 You want it bad, you'll get it bad.
%
scenario, n.:
 An imagined sequence of events that provides the context in
 which a business decision is made.  Scenarios always come in
 sets of three: best case, worst case, and just in case.
%
Schapiro's Explanation:
 The grass is always greener on the other side -- but that's
 because they use more manure.
%
Schlattwhapper, n.:
 The window shade that allows itself to be pulled down,
 hesitates for a second, then snaps up in your face.
  -- Rich Hall, "Sniglets"
%
Schmidt's Observation:
 All things being equal, a fat person uses more soap
 than a thin person.
%
Scott's First Law:
 No matter what goes wrong, it will probably look right.

Scott's Second Law:
 When an error has been detected and corrected, it will be found
 to have been wrong in the first place.
Corollary:
 After the correction has been found in error, it will be
 impossible to fit the original quantity back into the
 equation.
%
scribline, n.:
 The blank area on the back of credit cards where one's signature goes.
  -- "Sniglets", Rich Hall & Friends
%
Second Law of Business Meetings:
 If there are two possible ways to spell a person's name, you
 will pick the wrong one.

Corollary:
 If there is only one way to spell a name,
 you will spell it wrong, anyway.
%
Second Law of Final Exams:
 In your toughest final -- for the first time all year -- the most
 distractingly attractive student in the class will sit next to you.
%
Secretary's Revenge:
 Filing almost everything under "the".
%
Seleznick's Theory of Holistic Medicine:
 Ice Cream cures all ills.  Temporarily.
%
Self Test for Paranoia:
 You know you have it when you can't think of anything that's
 your own fault.
%
Senate, n.:
 A body of elderly gentlemen charged with high duties and misdemeanors.
  -- Ambrose Bierce
%
senility, n.:
 The state of mind of elderly persons with whom one happens to disagree.
%
serendipity, n.:
 The process by which human knowledge is advanced.
%
Serocki's Stricture:
 Marriage is always a bachelor's last option.
%
Shannon's Observation:
 Nothing is so frustrating as a bad situation that is beginning to
 improve.
%
share, n.:
 To give in, endure humiliation.
%
Shaw's Principle:
 Build a system that even a fool can use, and only a fool will
 want to use it.
%
Shedenhelm's Law:
 All trails have more uphill sections than they have downhill sections.
%
Shick's Law:
 There is no problem a good miracle can't solve.
%
Silverman's Law:
 If Murphy's Law can go wrong, it will.
%
Simon's Law:
 Everything put together falls apart sooner or later.
%
Skinner's Constant (or Flannagan's Finagling Factor):
 That quantity which, when multiplied by, divided by, added to,
 or subtracted from the answer you got, gives you the answer you
 should have gotten.
%
Slick's Three Laws of the Universe:
 (1)  Nothing in the known universe travels faster than a bad check.
 (2)  A quarter-ounce of chocolate = four pounds of fat.
 (3)  There are two types of dirt:  the dark kind, which is
     attracted to light objects, and the light kind, which is
     attracted to dark objects.
%
Slous' Contention:
 If you do a job too well, you'll get stuck with it.
%
Slurm, n.:
 The slime that accumulates on the underside of a soap bar when
 it sits in the dish too long.
  -- Rich Hall, "Sniglets"
%
Snacktrek, n.:
 The peculiar habit, when searching for a snack, of constantly
 returning to the refrigerator in hopes that something new will have
 materialized.
  -- Rich Hall, "Sniglets"
%
snappy repartee:
 What you'd say if you had another chance.
%
Sodd's Second Law:
 Sooner or later, the worst possible set of circumstances is
 bound to occur.
%
Software, n.:
 Formal evening attire for female computer analysts.
%
Some points to remember [about animals]:
 (1) Don't go to sleep under big animals, e.g., elephants, rhinoceri,
     hippopotamuses;
 (2) Don't put animals with sharp teeth or poisonous fangs down the
     front of your clothes;
 (3) Don't pat certain animals, e.g., crocodiles and scorpions or dogs
     you have just kicked.
  -- Mike Harding, "The Armchair Anarchist's Almanac"
%
spagmumps, n.:
 Any of the millions of Styrofoam wads that accompany mail-order items.
  -- "Sniglets", Rich Hall & Friends
%
Speer's 1st Law of Proofreading:
 The visibility of an error is inversely proportional to the
 number of times you have looked at it.
%
Spence's Admonition:
 Never stow away on a kamikaze plane.
%
Spirtle, n.:
 The fine stream from a grapefruit that always lands right in your eye.
  -- Sniglets, "Rich Hall & Friends"
%
Spouse, n.:
 Someone who'll stand by you through all the trouble you
 wouldn't have had if you'd stayed single.
%
squatcho, n.:
 The button at the top of a baseball cap.
  -- "Sniglets", Rich Hall & Friends
%
standards, n.:
 The principles we use to reject other people's code.
%
statistics, n.:
 A system for expressing your political prejudices in convincing
 scientific guise.
%
Steckel's Rule to Success:
 Good enough is never good enough.
%
Steele's Law:
 There exist tasks which cannot be done by more than ten men
 or fewer than one hundred.
%
Steele's Plagiarism of Somebody's Philosophy:
 Everybody should believe in something -- I believe I'll have
 another drink.
%
Steinbach's Guideline for Systems Programming:
 Never test for an error condition you don't know how to handle.
%
Stenderup's Law:
 The sooner you fall behind, the more time you will have to catch up.
%
Stock's Observation:
 You no sooner get your head above water but what someone pulls
 your flippers off.
%
Stone's Law:
 One man's "simple" is another man's "huh?"
%
strategy, n.:
 A comprehensive plan of inaction.
%
Strategy:
 A long-range plan whose merit cannot be evaluated until sometime
 after those creating it have left the organization.
%
Stult's Report:
 Our problems are mostly behind us.  What we have to do now is
 fight the solutions.
%
Stupid, n.:
 Losing $25 on the game and $25 on the instant replay.
%
Sturgeon's Law:
 90% of everything is crud.
%
sugar daddy, n.:
 A man who can afford to raise cain.
%
SUN Microsystems:
 The Network IS the Load Average.
%
sunset, n.:
 Pronounced atmospheric scattering of shorter wavelengths,
 resulting in selective transmission below 650 nanometers with
 progressively reducing solar elevation.
%
sushi, n.:
 When that-which-may-still-be-alive is put on top of rice and
 strapped on with electrical tape.
%
Sushido, n.:
 The way of the tuna.
%
Swahili, n.:
 The language used by the National Enquirer to print their retractions.
  -- Johnny Hart
%
Sweater, n.:
 A garment worn by a child when its mother feels chilly.
%
Swipple's Rule of Order:
 He who shouts the loudest has the floor.
%
system-independent, adj.:
 Works equally poorly on all systems.
%
T-shirt of the Day:
 Head for the Mountains
  -- courtesy Anheuser-Busch beer

Followup T-shirt of the Day (on the same scenic background):
 If you liked the mountains, head for the Busch!
  -- courtesy someone else
%
T-shirt Of The Day:
 I'm the person your mother warned you about.
%
T-shirt:
 Life is *not* a Cabaret, and stop calling me chum!
%
Tact, n.:
 The unsaid part of what you're thinking.
%
take forceful action:
 Do something that should have been done a long time ago.
%
tax office, n.:
 Den of inequity.
%
Taxes, n.:
 Of life's two certainties, the only one for which you can get
 an extension.
%
taxidermist, n.:
 A man who mounts animals.
%
TCP/IP Slang Glossary, #1:

Gong, n: Medieval term for privy, or what pased for them in that era.
Today used whimsically to describe the aftermath of a bogon attack. Think
of our community as the Galapagos of the English language.

"Vogons may read you bad poetry, but bogons make you study obsolete RFCs."
  -- Dave Mills
%
teamwork, n.:
 Having someone to blame.
%
Technicality, n.:
 In an English court a man named Home was tried for slander in having
 accused a neighbor of murder.  His exact words were: "Sir Thomas Holt
 hath taken a cleaver and stricken his cook upon the head, so that one
 side of his head fell on one shoulder and the other side upon the
 other shoulder."  The defendant was acquitted by instruction of the
 court, the learned judges holding that the words did not charge murder,
 for they did not affirm the death of the cook, that being only an
 inference.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Telephone, n.:
 An invention of the devil which abrogates some of the advantages
 of making a disagreeable person keep his distance.
  -- Ambrose Bierce
%
telepression, n.:
 The deep-seated guilt which stems from knowing that you did not try
 hard enough to look up the number on your own and instead put the
 burden on the directory assistant.
  -- "Sniglets", Rich Hall & Friends
%
Teutonic:
 Not enough gin.
%
The 357.73 Theory:
 Auditors always reject expense accounts
 with a bottom line divisible by 5.
%
The Abrams' Principle:
 The shortest distance between two points is off the wall.
%
The Ancient Doctrine of Mind Over Matter:
 I don't mind... and you don't matter.
  -- As revealed to reporter G. Rivera by Swami Havabanana
%
The Beatles:
 Paul McCartney's old back-up band.
%
The Briggs-Chase Law of Program Development:
 To determine how long it will take to write and debug a
 program, take your best estimate, multiply that by two, add
 one, and convert to the next higher units.
%
The Consultant's Curse:
 When the customer has beaten upon you long enough, give him
 what he asks for, instead of what he needs.  This is very strong
 medicine, and is normally only required once.
%
The distinction between Jewish and goyish can be quite subtle, as the
following quote from Lenny Bruce illustrates:

 "I'm Jewish.  Count Basie's Jewish.  Ray Charles is Jewish.
Eddie Cantor's goyish.  The B'nai Brith is goyish.  The Hadassah is
Jewish.  Marine Corps -- heavy goyish, dangerous.

 "Kool-Aid is goyish.  All Drake's Cakes are goyish.
Pumpernickel is Jewish and, as you know, white bread is very goyish.
Instant potatoes -- goyish.  Black cherry soda's very Jewish.
Macaroons are very Jewish.  Fruit salad is Jewish.  Lime Jell-O is
goyish.  Lime soda is very goyish.  Trailer parks are so goyish that
Jews won't go near them ..."
  -- Arthur Naiman, "Every Goy's Guide to Yiddish"
%
The Fifth Rule:
 You have taken yourself too seriously.
%
The First Rule of Program Optimization:
 Don't do it.

The Second Rule of Program Optimization (for experts only!):
 Don't do it yet.
  -- Michael Jackson
%
The five rules of Socialism:
 (1) Don't think.
 (2) If you do think, don't speak.
 (3) If you think and speak, don't write.
 (4) If you think, speak and write, don't sign.
 (5) If you think, speak, write and sign, don't be surprised.
  -- being told in Poland, 1987
%
The Following Subsume All Physical and Human Laws:
 (1) You can't push on a string.
 (2) Ain't no free lunches.
 (3) Them as has, gets.
 (4) You can't win them all, but you sure as hell can lose them all.
%
The Golden Rule of Arts and Sciences:
 He who has the gold makes the rules.
%
The Gordian Maxim:
 If a string has one end, it has another.
%
The Great Bald Swamp Hedgehog:
 The Great Bald Swamp Hedgehog of Billericay displays, in courtship,
 his single prickle and does impressions of Holiday Inn desk clerks.
 Since this means him standing motionless for enormous periods of
 time he is often eaten in full display by The Great Bald Swamp
 Hedgehog Eater.
  -- Mike Harding, "The Armchair Anarchist's Almanac"
%
The Heineken Uncertainty Principle:
 You can never be sure how many beers you had last night.
%
The history of warfare is similarly subdivided, although here the phases
are Retribution, Anticipation, and Diplomacy.  Thus:

Retribution:
 I'm going to kill you because you killed my brother.
Anticipation:
 I'm going to kill you because I killed your brother.
Diplomacy:
 I'm going to kill my brother and then kill you on the
 pretext that your brother did it.
%
The Illiterati Programus Canto 1:
 A program is a lot like a nose: Sometimes it runs, and
 sometimes it blows.
%
The Kennedy Constant:
 Don't get mad -- get even.
%
The Law of the Letter:
 The best way to inspire fresh thoughts is to seal the envelope.
%
The Marines:
 The few, the proud, the dead on the beach.
%
The Marines:
 The few, the proud, the not very bright.
%
The Modelski Chain Rule:
(1) Look intently at the problem for several minutes.  Scratch your
 head at 20-30 second intervals.  Try solving the problem on your
 Hewlett-Packard.
(2) Failing this, look around at the class.  Select a particularly
 bright-looking individual.
(3) Procure a large chain.
(4) Walk over to the selected student and threaten to beat him severely
 with the chain unless he gives you the answer to the problem.
 Generally, he will.  It may also be a good idea to give him a sound
 thrashing anyway, just to show you mean business.
%
The most dangerous organization in America today is:
 (a) The KKK
 (b) The American Nazi Party
 (c) The Delta Frequent Flyer Club
%
The Official MBA Handbook on business cards:
 Avoid overly pretentious job titles such as "Lord of the Realm,
 Defender of the Faith, Emperor of India" or "Director of Corporate
 Planning."
%
The Official MBA Handbook on doing company business on an airplane:
 Do not work openly on top-secret company cost documents unless
 you have previously ascertained that the passenger next to you
 is blind, a rock musician on mood-ameliorating drugs, or the
 unfortunate possessor of a forty-seventh chromosome.
%
The Official MBA Handbook on the use of sunlamps:
 Use a sunlamp only on weekends.  That way, if the office wise guy
 remarks on the sudden appearance of your tan, you can fabricate
 some story about a sun-stroked weekend at some island Shangri-La
 like Caneel Bay.  Nothing is more transparent than leaving the
 office at 11:45 on a Tuesday night, only to return an Aztec sun
 god at 8:15 the next morning.
%
The Phone Booth Rule:
 A lone dime always gets the number nearly right.
%
The qotc (quote of the con) was Liz's:
 "My brain is paged out to my liver."
%
The real man's Bloody Mary:
 Ingredients: vodka, tomato juice, Tobasco, Worcestershire
 sauce, A-1 steak sauce, ice, salt, pepper, celery.

 Fill a large tumbler with vodka.
 Throw all the other ingredients away.
%
The Roman Rule:
 The one who says it cannot be done should never interrupt the
 one who is doing it.
%
The rules:
  (1) Thou shalt not worship other computer systems.
  (2) Thou shalt not impersonate Liberace or eat watermelon while
       sitting at the console keyboard.
  (3) Thou shalt not slap users on the face, nor staple their silly
      little card decks together.
  (4) Thou shalt not get physically involved with the computer system,
      especially if you're already married.
  (5) Thou shalt not use magnetic tapes as frisbees, nor use a disk
      pack as a stool to reach another disk pack.
  (6) Thou shalt not stare at the blinking lights for more than one
      eight hour shift.
  (7) Thou shalt not tell users that you accidentally destroyed their
      files/backup just to see the look on their little faces.
  (8) Thou shalt not enjoy cancelling a job.
  (9) Thou shalt not display firearms in the computer room.
 (10) Thou shalt not push buttons "just to see what happens".
%
The Second Law of Thermodynamics:
 If you think things are in a mess now, just wait!
  -- Jim Warner
%
The Seventh Commandments for Technicians:
 Work thou not on energized equipment, for if thou dost, thy fellow
 workers will surely buy beers for thy widow and console her in other
 ways.
%
The Sixth Commandment of Frisbee:
 The greatest single aid to distance is for the disc to be going in a
 direction you did not want.   (Goes the wrong way = Goes a long way.)
  -- Dan Roddick
%
The Third Law of Photography:
 If you did manage to get any good shots, they will be ruined
 when someone inadvertently opens the darkroom door and all of
 the dark leaks out.
%
The three biggest software lies:
 (1) *Of course* we'll give you a copy of the source.
 (2) *Of course* the third party vendor we bought that from
     will fix the microcode.
 (3) Beta test site?  No, *of course* you're not a beta test site.
%
The three laws of thermodynamics:
 (1) You can't get anything without working for it.
 (2) The most you can accomplish by working is to break even.
 (3) You can only break even at absolute zero.
%
Theorem: a cat has nine tails.
Proof:
 No cat has eight tails. A cat has one tail more than no cat.
 Therefore, a cat has nine tails.
%
Theorem: All positive integers are equal.
Proof: Sufficient to show that for any two positive integers, A and B, A = B.
 Further, it is sufficient to show that for all N > 0, if A and B
 (positive integers) satisfy (MAX(A, B) = N) then A = B.

Proceed by induction:
 If N = 1, then A and B, being positive integers, must both be 1.
 So A = B.

Assume that the theorem is true for some value k.  Take A and B with
 MAX(A, B) = k+1.  Then  MAX((A-1), (B-1)) = k.  And hence
 (A-1) = (B-1).  Consequently, A = B.
%
Theory of Selective Supervision:
 The one time in the day that you lean back and relax is
 the one time the boss walks through the office.
%
theory, n.:
 System of ideas meant to explain something, chosen with a view to
 originality, controversialism, incomprehensibility, and how good
 it will look in print.
%
There are three ways to get something done:
 (1) Do it yourself.
 (2) Hire someone to do it for you.
 (3) Forbid your kids to do it.
%
Those lovable Brits department:
 They also have trouble pronouncing `vitamin'.
%
Three rules for sounding like an expert:
 (1) Oversimplify your explanations to the point of uselessness.
 (2) Always point out second-order effects, but never point out
     when they can be ignored.
 (3) Come up with three rules of your own.
%
Thyme's Law:
 Everything goes wrong at once.
%
timesharing, n:
 An access method whereby one computer abuses many people.
%
Tip of the Day:
 Never fry bacon in the nude.

 [Correction: always fry bacon in the nude; you'll learn not to burn it]
%
TIPS FOR PERFORMERS:
 Playing cards have the top half upside-down to help cheaters.
 There are a finite number of jokes in the universe.
 Singing is a trick to get people to listen to music longer than
  they would ordinarily.
 There is no music in space.
 People will pay to watch people make sounds.
 Everything on stage should be larger than in real life.
%
today, n.:
 A nice place to visit, but you can't stay here for long.
%
toilet toupee, n.:
 Any shag carpet that causes the lid to become top-heavy, thus
 creating endless annoyance to male users.
  -- Rich Hall, "Sniglets"
%
Toni's Solution to a Guilt-Free Life:
 If you have to lie to someone, it's their fault.
%
transfer, n.:
 A promotion you receive on the condition that you leave town.
%
transparent, adj.:
 Being or pertaining to an existing, nontangible object.
 "It's there, but you can't see it"
  -- IBM System/360 announcement, 1964.

virtual, adj.:
 Being or pertaining to a tangible, nonexistent object.
 "I can see it, but it's not there."
  -- Lady Macbeth.
%
travel, n.:
 Something that makes you feel like you're getting somewhere.
%
"Trust me":
 Translation of the Latin "caveat emptor."
%
Truthful, adj.:
 Dumb and illiterate.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Tsort's Constant:
 1.67563, or precisely 1,237.98712567 times the difference between
the distance to the sun and the weight of a small orange.
  -- Terry Pratchett, "The Light Fantastic" (slightly modified)
%
Turnaucka's Law:
 The attention span of a computer is only as long as its
 electrical cord.
%
Tussman's Law:
 Nothing is as inevitable as a mistake whose time has come.
%
U.S. of A.:
 "Don't speak to the bus driver."
Germany:
 "It is strictly forbidden for passengers to speak to the driver."
England:
 "You are requested to refrain from speaking to the driver."
Scotland:
 "What have you got to gain by speaking to the driver?"
Italy:
 "Don't answer the driver."
%
Udall's Fourth Law:
 Any change or reform you make is going to have consequences you
 don't like.
%
Uncle Ed's Rule of Thumb:
 Never use your thumb for a rule.
 You'll either hit it with a hammer or get a splinter in it.
%
Underlying Principle of Socio-Genetics:
 Superiority is recessive.
%
understand, v.:
 To reach a point, in your investigation of some subject, at which
 you cease to examine what is really present, and operate on the
 basis of your own internal model instead.
%
Unfair animal names:

-- tsetse fly   -- bullhead
-- booby   -- duck-billed platypus
-- sapsucker   -- Clarence
  -- Gary Larson
%
unfair competition, n.:
 Selling cheaper than we do.
%
union, n.:
 A dues-paying club workers wield to strike management.
%
Universe, n.:
 The problem.
%
University, n.:
 Like a software house, except the software's free, and it's usable,
 and it works, and if it breaks they'll quickly tell you how to fix
 it, and ...

 [Okay, okay, I'll leave it in, but I think you're destroying
  the credibility of the entire fortune program.  Ed.]
%
Unnamed Law:
 If it happens, it must be possible.
%
untold wealth, n.:
 What you left out on April 15th.
%
User n.:
 A programmer who will believe anything you tell him.
%
user, n.:
 The word computer professionals use when they mean "idiot."
  -- Dave Barry, "Claw Your Way to the Top"

[I always thought "computer professional" was the phrase hackers used
 when they meant "idiot."  Ed.]
%
vacation, n.:
 A two-week binge of rest and relaxation so intense that
 it takes another 50 weeks of your restrained workaday
 life-style to recuperate.
%
Vail's Second Axiom:
 The amount of work to be done increases in proportion to the
 amount of work already completed.
%
Van Roy's Law:
 An unbreakable toy is useful for breaking other toys.
%
Van Roy's Law:
 Honesty is the best policy - there's less competition.

Van Roy's Truism:
 Life is a whole series of circumstances beyond your control.
%
Vanilla, adj.:
 Ordinary flavor, standard.  See FLAVOR.  When used of food,
 very often does not mean that the food is flavored with vanilla
 extract!  For example, "vanilla-flavored won ton soup" (or simply
 "vanilla won ton soup") means ordinary won ton soup, as opposed to hot
 and sour won ton soup.
%
Velilind's Laws of Experimentation:
 (1) If reproducibility may be a problem, conduct the test only once.
 (2) If a straight line fit is required, obtain only two data points.
%
Viking, n.:
 1. Daring Scandinavian seafarers, explorers, adventurers,
 entrepreneurs world-famous for their aggressive, nautical import
 business, highly leveraged takeovers and blue eyes.
 2. Bloodthirsty sea pirates who ravaged northern Europe beginning
 in the 9th century.

Hagar's note: The first definition is much preferred; the second is used
only by malcontents, the envious, and disgruntled owners of waterfront
property.
%
VMS, n.:
 The world's foremost multi-user adventure game.
%
volcano, n.:
 A mountain with hiccups.
%
Volley Theory:
 It is better to have lobbed and lost than never to have lobbed at all.
%
vuja de:
 The feeling that you've *never*, *ever* been in this situation before.
%
Walters' Rule:
 All airline flights depart from the gates most distant from
 the center of the terminal.  Nobody ever had a reservation
 on a plane that left Gate 1.
%
Watson's Law:
 The reliability of machinery is inversely proportional to the
 number and significance of any persons watching it.
%
"We'll look into it":
 By the time the wheels make a full turn, we
 assume you will have forgotten about it, too.
%
we:
 The single most important word in the world.
%
weapon, n.:
 An index of the lack of development of a culture.
%
Wedding, n:
 A ceremony at which two persons undertake to become one, one undertakes
 to become nothing and nothing undertakes to become supportable.
  -- Ambrose Bierce
%
Weed's Axiom:
 Never ask two questions in a business letter.
 The reply will discuss the one in which you are
 least interested and say nothing about the other.
%
Weiler's Law:
 Nothing is impossible for the man who doesn't have to do it himself.
%
Weinberg's First Law:
 Progress is only made on alternate Fridays.
%
Weinberg's Principle:
 An expert is a person who avoids the small errors while
 sweeping on to the grand fallacy.
%
Weinberg's Second Law:
 If builders built buildings the way programmers wrote programs,
 then the first woodpecker that came along would destroy civilization.
%
Weiner's Law of Libraries:
 There are no answers, only cross references.
%
well-adjusted, adj.:
 The ability to play bridge or golf as if they were games.
%
Westheimer's Discovery:
 A couple of months in the laboratory can frequently save a
 couple of hours in the library.
%
When asked the definition of "pi":
The Mathematician:
 Pi is the number expressing the relationship between the
 circumference of a circle and its diameter.
The Physicist:
 Pi is 3.1415927, plus or minus 0.000000005.
The Engineer:
 Pi is about 3.
%
Whistler's Law:
 You never know who is right, but you always know who is in charge.
%
White's Statement:
 Don't lose heart!

Owen's Commentary on White's Statement:
 ...they might want to cut it out...

Byrd's Addition to Owen's Commentary:
 ...and they want to avoid a lengthy search.
%
Whitehead's Law:
 The obvious answer is always overlooked.
%
Wiker's Law:
 Government expands to absorb revenue and then some.
%
Wilcox's Law:
 A pat on the back is only a few centimeters from a kick in the pants.
%
  William Safire's Rules for Writers:

Remember to never split an infinitive.  The passive voice should never be
used.  Do not put statements in the negative form.  Verbs have to agree with
their subjects.  Proofread carefully to see if you words out.  If you reread
your work, you can find on rereading a great deal of repetition can be
avoided by rereading and editing.  A writer must not shift your point of
view.  And don't start a sentence with a conjunction.  (Remember, too, a
preposition is a terrible word to end a sentence with.) Don't overuse
exclamation marks!!  Place pronouns as close as possible, especially in long
sentences, as of 10 or more words, to their antecedents.  Writing carefully,
dangling participles must be avoided.  If any word is improper at the end of
a sentence, a linking verb is.  Take the bull by the hand and avoid mixing
metaphors.  Avoid trendy locutions that sound flaky.  Everyone should be
careful to use a singular pronoun with singular nouns in their writing.
Always pick on the correct idiom.  The adverb always follows the verb.  Last
but not least, avoid cliches like the plague; seek viable alternatives.
%
Williams and Holland's Law:
 If enough data is collected, anything may be proven by statistical
 methods.
%
Wilner's Observation:
 All conversations with a potato should be conducted in private.
%
Wit, n.:
 The salt with which the American Humorist spoils his cookery
 ... by leaving it out.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
wok, n.:
 Something to thwow at a wabbit.
%
wolf, n.:
 A man who knows all the ankles.
%
Wombat's Laws of Computer Selection:
 (1) If it doesn't run Unix, forget it.
 (2) Any computer design over 10 years old is obsolete.
 (3) Anything made by IBM is junk. (See number 2)
 (4) The minimum acceptable CPU power for a single user is a
     VAX/780 with a floating point accelerator.
 (5) Any computer with a mouse is worthless.
  -- Rich Kulawiec
%
Woodward's Law:
 A theory is better than its explanation.
%
Woolsey-Swanson Rule:
 People would rather live with a problem they cannot
 solve rather than accept a solution they cannot understand.
%
Work Rule: Leave of Absence (for an Operation):
 We are no longer allowing this practice.  We wish to discourage any
thoughts that you may not need all of whatever you have, and you should not
consider having anything removed.  We hired you as you are, and to have
anything removed would certainly make you less than we bargained for.
%
work, n.:
 The blessed respite from screaming kids and
 soap operas for which you actually get paid.
%
Worst Month of 1981 for Downhill Skiing:
 August.  The lift lines are the shortest, though.
  -- Steve Rubenstein
%
Worst Month of the Year:
 February.  February has only 28 days in it, which means that if
 you rent an apartment, you are paying for three full days you
 don't get.  Try to avoid Februarys whenever possible.
  -- Steve Rubenstein
%
Worst Response To A Crisis, 1985:
 From a readers' Q and A column in TV GUIDE: "If we get involved
 in a nuclear war, would the electromagnetic pulses from exploding bombs
 damage my videotapes?"
%
Worst Vegetable of the Year:
 The brussels sprout.  This is also the worst vegetable of next year.
  -- Steve Rubenstein
%
write-protect tab, n.:
 A small sticker created to cover the unsightly notch carelessly left
 by disk manufacturers.  The use of the tab creates an error message
 once in a while, but its aesthetic value far outweighs the momentary
 inconvenience.
  -- Robb Russon
%
WYSIWYG:
 What You See Is What You Get.
%
XIIdigitation, n.:
 The practice of trying to determine the year a movie was made
 by deciphering the Roman numerals at the end of the credits.
  -- Rich Hall, "Sniglets"
%
Year, n.:
 A period of three hundred and sixty-five disappointments.
  -- Ambrose Bierce, "The Devil's Dictionary"
%
Yinkel, n.:
 A person who combs his hair over his bald spot, hoping no one
 will notice.
  -- Rich Hall, "Sniglets"
%
yo-yo, n.:
 Something that is occasionally up but normally down.
 (see also Computer).
%
Zall's Laws:
 (1) Any time you get a mouthful of hot soup, the next thing you do
    will be wrong.
 (2) How long a minute is, depends on which side of the bathroom
    door you're on.
%
zeal, n.:
 Quality seen in new graduates -- if you're quick.
%
Zero Defects, n.:
 The result of shutting down a production line.
%
Zymurgy's Law of Volunteer Labor:
 People are always available for work in the past tense.
%
Obscurism:
 The practice of peppering daily life with obscure
references as a subliminal means of showcasing both one's education
and one's wish to disassociate from the world of mass culture.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
McJob:
 A low-pay, low-prestige, low-benefit, no-future job in the
service sector.  Frequently considered a satisfying career choice by
those who have never held one.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Poverty Jet Set:
 A group of people given to chronic traveling at the expense of
long-term job stability or a permanent residence.  Tend to have doomed
and extremely expensive phone-call relationships with people named
Serge or Ilyana.  Tend to discuss frequent-flyer programs at parties.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Historic Underdosing:
 To live in a period of time when nothing seems to happen.
Major symptoms include addiction to newspapers, magazines, and TV news
broadcasts.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Historic Overdosing:
 To live in a period of time when too much seems to happen.
Major symptoms include addiction to newspapers, magazines, and TV news
broadcasts.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Historical Slumming:
 The act of visiting locations such as diners, smokestack
industrial sites, rural villages -- locations where time appears to
have been frozen many years back -- so as to experience relief when
one returns back to "the present."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Brazilification:
 The widening gulf between the rich and the poor and the
accompanying disappearance of the middle classes.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Vaccinated Time Travel:
 To fantasize about traveling backward in time, but only
with proper vaccinations.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Decade Blending:
 In clothing: the indiscriminate combination of two or more
items from various decades to create a personal mood: Sheila =
Mary Quant earrings (1960s) + cork wedgie platform shows (1970s) +
black leather jacket (1950s and 1980s).
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Veal-Fattening Pen:
 Small, cramped office workstations built of
fabric-covered disassemblable wall partitions and inhabited by junior
staff members.  Named after the small preslaughter cubicles used by
the cattle industry.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Emotional Ketchup Burst:
 The bottling up of opinions and emotions inside oneself so
that they explosively burst forth all at once, shocking and confusing
employers and friends -- most of whom thought things were fine.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Bleeding Ponytail:
 An elderly, sold-out baby boomer who pines for hippie or
presellout days.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Boomer Envy:
 Envy of material wealth and long-range material security
accrued by older members of the baby boom generation by virtue of
fortunate births.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Clique Maintenance:
 The need of one generation to see the generation following it
as deficient so as to bolster its own collective ego: "Kids today do
nothing.  They're so apathetic.  We used to go out and protest.  All
they do is shop and complain."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Consensus Terrorism:
 The process that decides in-office attitudes and behavior.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Sick Building Migration:
 The tendency of younger workers to leave or avoid jobs in
unhealthy office environments or workplaces affected by the Sick
Building Syndrome.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Recurving:
 Leaving one job to take another that pays less but places one
back on the learning curve.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Ozmosis:
 The inability of one's job to live up to one's self-image.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Power Mist:
 The tendency of hierarchies in office environments to be diffuse
and preclude crisp articulation.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Overboarding:
 Overcompensating for fears about the future by plunging
headlong into a job or life-style seemingly unrelated to one's
previous life interests: i.e., Amway sales, aerobics, the Republican
party, a career in law, cults, McJobs....
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Earth Tones:
 A youthful subgroup interested in vegetarianism, tie-dyed
outfits, mild recreational drugs, and good stereo equipment.  Earnest,
frequently lacking in humor.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Ethnomagnetism:
 The tendency of young people to live in emotionally
demonstrative, more unrestrained ethnic neighborhoods: "You wouldn't
understand it there, mother -- they *hug* where I live now."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Mid-Twenties Breakdown:
 A period of mental collapse occurring in one's twenties,
often caused by an inability to function outside of school or
structured environments coupled with a realization of one's essential
aloneness in the world.  Often marks induction into the ritual of
pharmaceutical usage.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Successophobia:
 The fear that if one is successful, then one's personal needs
will be forgotten and one will no longer have one's childish needs
catered to.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Safety Net-ism:
 The belief that there will always be a financial and emotional
safety net to buffer life's hurts.  Usually parents.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Divorce Assumption:
 A form of Safety Net-ism, the belief that if a marriage
doesn't work out, then there is no problem because partners can simply
seek a divorce.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Anti-Sabbatical:
 A job taken with the sole intention of staying only for a
limited period of time (often one year).  The intention is usually to
raise enough funds to partake in another, more meaningful activity
such as watercolor sketching in Crete, or designing computer knit
sweaters in Hong Kong.  Employers are rarely informed of intentions.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Legislated Nostalgia:
 To force a body of people to have memories they do not
actually possess: "How can I be a part of the 1960s generation when I
don't even remember any of it?"
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Now Denial:
 To tell oneself that the only time worth living in is the past and
that the only time that may ever be interesting again is the future.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Bambification:
 The mental conversion of flesh and blood living creatures into
cartoon characters possessing bourgeois Judeo-Christian attitudes and
morals.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Diseases for Kisses (Hyperkarma):
 A deeply rooted belief that punishment will somehow always be
far greater than the crime: ozone holes for littering.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Spectacularism:
 A fascination with extreme situations.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Lessness:
 A philosophy whereby one reconciles oneself with diminishing
expectations of material wealth: "I've given up wanting to make a
killing or be a bigshot.  I just want to find happiness and maybe open
up a little roadside cafe in Idaho."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Status Substitution:
 Using an object with intellectual or fashionable cachet to
substitute for an object that is merely pricey: "Brian, you left your
copy of Camus in your brother's BMW."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Survivulousness:
 The tendency to visualize oneself enjoying being the last
person on Earth.  "I'd take a helicopter up and throw microwave ovens
down on the Taco Bell."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Platonic Shadow:
 A nonsexual friendship with a member of the opposite sex.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Mental Ground Zero:
 The location where one visualizes oneself during the dropping
of the atomic bomb; frequently, a shopping mall.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Cult of Aloneness:
 The need for autonomy at all costs, usually at the expense of
long-term relationships.  Often brought about by overly high
expectations of others.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Celebrity Schadenfreude:
 Lurid thrills derived from talking about celebrity deaths.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
The Emperor's New Mall:
 The popular notion that shopping malls exist on the insides only
and have no exterior.  The suspension of visual disbelief engendered
by this notion allows shoppers to pretend that the large, cement
blocks thrust into their environment do not, in fact, exist.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Poorochrondria:
 Hypochrondria derived from not having medical insurance.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Personal Tabu:
 A small rule for living, bordering on a superstition, that
allows one to cope with everyday life in the absence of cultural or
religious dictums.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Architectural Indigestion:
 The almost obsessive need to live in a "cool"
architectural environment.  Frequently related objects of fetish
include framed black-and-white art photography (Diane Arbus a
favorite); simplistic pine furniture; matte black high-tech items such
as TVs, stereos, and telephones; low-wattage ambient lighting; a lamp,
chair, or table that alludes to the 1950s; cut flowers with complex
names.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Japanese Minimalism:
 The most frequently offered interior design aesthetic used by
rootless career-hopping young people.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Bread and Circuits:
 The electronic era tendency to view party politics as corny --
no longer relevant of meaningful or useful to modern societal issues,
and in many cases dangerous.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Voter's Block:
 The attempt, however futile, to register dissent with the
current political system by simply not voting.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Armanism:
 After Giorgio Armani; an obsession with mimicking the seamless
and (more importantly) *controlled* ethos of Italian couture.  Like
Japanese Minimalism, Armanism reflects a profound inner need for
control.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Poor Buoyancy:
 The realization that one was a better person when one had less
money.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Musical Hairsplitting:
 The act of classifying music and musicians into pathologically
picayune categories: "The Vienna Franks are a good example of urban
white acid fold revivalism crossed with ska."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
101-ism:
 The tendency to pick apart, often in minute detail, all
aspects of life using half-understood pop psychology as a tool.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Yuppie Wannabes:
 An X generation subgroup that believes the myth of a yuppie
life-style being both satisfying and viable.  Tend to be highly in
debt, involved in some form of substance abuse, and show a willingness
to talk about Armageddon after three drinks.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Ultra Short Term Nostalgia:
 Homesickness for the extremely recent past: "God, things seemed
so much better in the world last week."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Rebellion Postponement:
 The tendency in one's youth to avoid traditionally youthful
activities and artistic experiences in order to obtain serious career
experience.  Sometimes results in the mourning for lost youth at about
age thirty, followed by silly haircuts and expensive joke-inducing
wardrobes.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Conspicuous Minimalism:
 A life-style tactic similar to Status Substitution.  The
nonownership of material goods flaunted as a token of moral and
intellectual superiority.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Cafe Minimalism:
 To espouse a philosophy of minimalism without actually putting
into practice any of its tenets.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
O'Propriation:
 The inclusion of advertising, packaging, and entertainment
jargon from earlier eras in everyday speech for ironic and/or comic
effect: "Kathleen's Favorite Dead Celebrity party was tons o'fun" or
"Dave really thinks of himself as a zany, nutty, wacky, and madcap
guy, doesn't he?"
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Air Family:
 Describes the false sense of community experienced among coworkers
in an office environment.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Squirming:
 Discomfort inflicted on young people by old people who see no
irony in their gestures.  "Karen died a thousand deaths as her father
made a big show of tasting a recently manufactured bottle of wine
before allowing it to be poured as the family sat in Steak Hut.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Recreational Slumming:
 The practice of participating in recreational activities
of a class one perceives as lower than one's own: "Karen!  Donald!
Let's go bowling tonight!  And don't worry about shoes ... apparently
you can rent them."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Conversational Slumming:
 The self-conscious enjoyment of a given conversation
precisely for its lack of intellectual rigor.  A major spin-off
activity of Recreational Slumming.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Occupational Slumming:
 Taking a job well beneath one's skill or education level
as a means of retreat from adult responsibilities and/or avoiding
failure in one's true occupation.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Anti-Victim Device:
 A small fashion accessory worn on an otherwise
conservative outfit which announces to the world that one still has a
spark of individuality burning inside: 1940s retro ties and earrings
(on men), feminist buttons, noserings (women), and the now almost
completely extinct teeny weeny "rattail" haircut (both sexes).
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Nutritional Slumming:
 Food whose enjoyment stems not from flavor but from a
complex mixture of class connotations, nostalgia signals, and
packaging semiotics: Katie and I bought this tub of Multi-Whip instead
of real whip cream because we thought petroleum distillate whip
topping seemed like the sort of food that air force wives stationed in
Pensacola back in the early sixties would feed their husbands to
celebrate a career promotion.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Tele-Parabilizing:
 Morals used in everyday life that derive from TV sitcom plots:
"That's just like the episode where Jan loses her glasses!"
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
QFD:
 Quelle fucking drag.  "Jamie got stuck at Rome airport for
thirty-six hours and it was, like, totally QFD."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
QFM:
 Quelle fashion mistake.  "It was really QFM.  I mean painter
pants?  That's 1979 beyond belief."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Me-ism:
 A search by an individual, in the absence of training in
traditional religious tenets, to formulate a personally tailored
religion by himself.  Most frequently a mishmash of reincarnation,
personal dialogue with a nebulously defined god figure, naturalism,
and karmic eye-for-eye attitudes.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Paper Rabies:
 Hypersensitivity to littering.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Bradyism:
 A multisibling sensibility derived from having grown up in
large families.  A rarity in those born after approximately 1965,
symptoms of Bradyism include a facility for mind games, emotional
withdrawal in situations of overcrowding, and a deeply felt need for a
well-defined personal space.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Black Holes:
 An X generation subgroup best known for their possession of
almost entirely black wardrobes.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Black Dens:
 Where Black Holes live; often unheated warehouses with Day-Glo
spray painting, mutilated mannequins, Elvis references, dozens of
overflowing ashtrays, mirror sculptures, and Velvet Underground music
playing in background.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Strangelove Reproduction:
 Having children to make up for the fact that one no longer
believes in the future.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Squires:
 The most common X generation subgroup and the only subgroup
given to breeding.  Squires exist almost exclusively in couples and
are recognizable by their frantic attempts to create a semblance of
Eisenhower-era plenitude in their daily lives in the face of
exorbitant housing prices and two-job life-styles.  Squires tend to be
continually exhausted from their voraciously acquisitive pursuit of
furniture and knickknacks.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Poverty Lurks:
 Financial paranoia instilled in offspring by depression-era
parents.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Pull-the-Plug, Slice the Pie:
 A fantasy in which an offspring mentally tallies up the
net worth of his parents.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated
     Culture"
%
Underdogging:
 The tendency to almost invariably side with the underdog in a
given situation.  The consumer expression of this trait is the
purchasing of less successful, "sad," or failing products: "I know
these Vienna franks are heart failure on a stick, but they were so sad
looking up against all the other yuppie food items that I just had to
buy them."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated Culture"
%
2 + 2 = 5-ism:
 Caving in to a target marketing strategy aimed at oneself after
holding out for a long period of time.  "Oh, all right, I'll buy your
stupid cola.  Now leave me alone."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated Culture"
%
Option Paralysis:
 The tendency, when given unlimited choices, to make none.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated Culture"
%
Personality Tithe:
 A price paid for becoming a couple; previously amusing
human beings become boring: "Thanks for inviting us, but Noreen and I
are going to look at flatware catalogs tonight.  Afterward we're going
to watch the shopping channel."
  -- Douglas Coupland, "Generation X: Tales for an Accelerated Culture"
%
Jack-and-Jill Party:
A Squire tradition; baby showers to which both men and
women friends are invited as opposed to only women.  Doubled
purchasing power of bisexual attendance brings gift values up to
Eisenhower-era standards.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated Culture"
%
Down-Nesting:
 The tendency of parents to move to smaller, guest-room-free
houses after the children have moved away so as to avoid children aged
20 to 30 who have boomeranged home.
  -- Douglas Coupland, "Generation X: Tales for an Accelerated Culture"
%
greenrd's law
 Evey post disparaging someone else's spelling or grammar, or lauding
 one's own spelling or grammar, will inevitably contain a spelling or
 grammatical error.
  -- greenrd in http://www.kuro5hin.org/comments/2002/4/16/61744/5230?pid=5#6
%
1133:  1.n. The multiplexor enclosure for the 1130 Minicomputer.  2.n. A
division headquarters building in Westchester Avenue, White Plains, NY.  IBM
buildings in the USA each have an identifying number, and this number is
often used in references.  For example, the 801 minicomputer (whose
architecture is used in the IBM RT PC product) is named after Building 801,
the T. J. Watson Research Laboratory near Yorktown Heights.
%
80-80 listing:  n. A program that could read a deck of cards and print each
80-character card image as a new line on a printer.  It's said that it was
possible to write an 80-80 listing program on the initial program card for
the IBM 1401.  See boot.
%
80-column mind:  n. A narrow or blinkered mind.  Usually applied to people
who, conceptually at least, would prefer to be able to lay their hands
directly on their data, and to whom the transition from cards to tape was a
traumatic experience.  Nobody has dared tell them about [magnetic] disks yet.
(It is said that these people will be buried "face down, 9-edge forward",
"face up, 12-edge first", or "face down, nine to the throat ".)
%
80x24 artist:  n. Person who can do nice drawings on a non-graphic screen
which has 24 or 25 rows of 80 characters.
%
9-edge:  n. The bottom edge of a standard Hollerith computer card.  So named
because a card had twelve rows; two at the top (variously named) and ten
below (named 0 through 9).  The lowest of these was row 9; hence the nearest
edge was 9-Edge.  (The other edge was often known as the 12-edge.) See also
face down, nine to the throat.
%
ABEND:  (ab-end) 1.n. The undesirable termination of a program (or system).
From "ABnormal ENDing".  Invariably due to human error at some point that the
system was unable to overcome or ignore.  Typically results in catch-all
error messages (e.g., "syntax error") that rarely help determine the cause.
2. v. To end abnormally.  See also crash.
%
A-Box:  n. A primary storage unit the one closest to the controller.  Most
370 storage peripherals come in two flavours.  The A-Box (also called head of
string, or Model A) either houses the controller (e.g., 3422), is the
controller (e.g., 3480), or connects to the controller.  The B-Box (Model B)
is used for extending the string.  Some strings can be connected to the
controller at both ends, in which case the unit at the end of the string is
usually a Model D.
%
APAR:  (ay-parr) 1.n. Authorized Program Analysis Report.  This is an
official report to IBM of an error in a program.  The acronym is used so
often that most people don't know what it stands for.  This is one of the
many acronyms whose expansion and meaning has changed with time.  The group
in Poughkeepsie that wrote the early System/360 systems programs (compilers,
sorts, etc.) were called "Applied Programming" or "Application Programming",
hence a request for a fix was called an "Applied Programming Assistance
Request".  In the period between the demise of the Applied Programming
organisation and the determination that "AP" could mean "Authorized Program"
the acronym was interpreted as "Always Process As Rush".  [This actually got
printed on some forms.] 2. v. To make such a report.  Note that only programs
(and not microcode) can be APARed.  3. n. A specific fix for a reported
problem [an incorrect usage].  "I've applied all the APARs, but it still
crashes".  Also APAR avalanche, the result of innocently requesting a single
APAR to fix a simple problem, only to find that it requires a number of other
fixes to be installed first, and that these in turn require others, and
these...
%
APARable situation:  n. A reportable bug.  See also critical situation, known
restriction.
%
APL bigot:  n. One who considers APL to be the finest programming language
available.  APL (A Programming Language) is a popular, mathematically
oriented, unreadable, interactive language.  Usage "An APL bigot does not
know there are any other programming languages", or "It's an APL bigot -
cannot speak English".  Alon Caplin (known for his love of APL and for his
sense of humour) was heard to say "You can always tell an APL bigot, but not
much".  See also bigot.
%
ASCII bit:  (ass-key) n. A bit set to select ASCII (American National
Standard Code for Information Interchange) coded information.  In the
System/360 computer architecture (now obsolete), bit 12 of the Program Status
Word was designated the ASCII bit.  When the bit was off (0), the system ran
using the EBCDIC (Extended Binary Coded Decimal Interchange Code) coded
character set.  When on (1), the system ran using the ASCII coded character
set.  However, this ASCII operation was never used by any of the IBM
operating systems and so the architects redefined the bit for Basic Control
Mode (0) and Extended Control Mode (1).  In hindsight, it seems that the
ASCII setting might have been convenient for communication between modern
mainframes and personal computers.  Programmers at one time could turn on the
ASCII bit in the Program Check New PSW of a 3195 Processor; this (if loaded)
would drive the processor into a continuous loop of Program Interruption (bad
PSW) which would fetch that same PSW (still bad).
%
Amber:  n. The master disk of a public conferencing facility.  This refers to
Roger Zelazny's Nine Princes In Amber fantasy series.  Amber is (sort of) the
real universe; other apparent realities are (in some sense) incomplete copies
of Amber (they are called "shadows" of Amber).  See master.
%
American tourist:  n. A VIP (Visiting (sic) Important Person) from the USA.
A breed of corporate manager or staff assistant that suffers from an urge to
visit European locations (usually within driving distance of the
Mediterranean) during the months of July or August, thus preventing employees
from taking their vacations when they would like to.  1986 (the year of the
Libyan affair and the Paris bombings) was a nice quiet year for Europeans.
%
BAD:  adj.  Of a program Broken As Designed.  Used to describe a program
whose design, rather than implementation, is flawed.  This term originated
(and is mostly used) outside IBM, often in reaction to an IBM "Working as
Designed" APAR response.
%
BICARSA GLAPPR:  (bi-carsa glapper) n. The cornerstone applications of
commercial computing.  An abbreviation for Billing, Inventory Control,
Accounts Receivable, Sales Analysis, General Ledger, Accounts Payable,
PayRoll; the applications for which IBM's mainframes were built and on which
its fame and fortune were founded.  Usage "Yeah, it's fast, but how does it
do on BICARSA GLAPPR?"
%
BOOF:  (rhymes with aloof) n. Byte-Oriented Operand Feature.  An extension to
the System/360 architecture that permits references to data objects on
arbitrary byte boundaries.  This is a hardware "feature" introduced with
System/370 that, although a boon to the lazy programmer, effectively removed
an important debugging facility (a specification interruption for alignment
errors) of the System/360 architecture.  For a considerable performance
penalty, program errors are now hidden from the programmer.  Originally
designed to meet a new requirement for FORTRAN standards (in the standard,
FORTRAN COMMON declarations were defined as being allocated with no
intervening space for alignment).  Also implemented ('tis said) for the
convenience of programmers of Access Method modules who were faced with the
problems of external data not falling on proper memory-aligned boundaries
when read into main memory.  [BOOF was sometimes called BOO, as on the Model
195 it was not a feature, and was therefore always available.] See feature.
%
BRS:  v. See Big Red Switch.
%
BYTE8406:  (bite-eighty-four-oh-six) v. To start a discussion about old IBM
machines.  See also forum.
%
BYTE8406 syndrome:  1.n. The tendency for any social discussion among
computer people to drift towards exaggeration.  "Well, when I started using
computers they didn't even use electricity yet, much less transistors".  See
forum.  2.n. The tendency for oppression to waste resources.  Derives from
the observation that "erasing a banned public file does not destroy the
information, but merely creates an uncountable number of private copies".  It
was first diagnosed in September 1984, when the BYTE8406 forum was removed
from the IBMPC Conference.
%
Beamer, Beemer:  1.n. An obvious IBM employee.  A person who works for IBM
and wears his badge in public, outside of any IBM building - or even further
afield.  May also wear white socks.  This is the "outside" definition for a
stereotyped IBM person; a local radio show in the Hudson Valley features a
spot called "The Beemertons", a kind of IBM soap opera.  2.n. In the USA a
brand of motor car, from the Bayerische Motoren Werke.
%
BiCapitalization:  n. The PracTice of PutTing CapiTal LetTers in the MidDle
of WorDs.  This was originally used to refer to microcomputer software
trademarks such as VisiCalc, EasyWriter, and FileCommand but has since spread
even to products totally unrelated to computing, and to many more than two
capitals.  The mainframe world, however, is still mostly devoid of
BiCapitalization - in that environment the use of abbreviations is still the
PMRR (Preferred Method of Reducing Readability).
%
Big Blue:  1.n. IBM (when used by customers and competitors).  2.n. The Data
Processing Division (when used by people concerned with processors that do
not use the System/370 architecture).  [The DPD no longer exists, but the
phrase big blue boxes is still used to refer to large System/370
installations.]
%
Big Blue Zoo:  n. The manufacturing plant and laboratory complex located at
the junction of Highway 52 and 37th Street, Rochester, Minnesota, USA.  It
really is blue.  See also zoo.
%
Big Four:  n. The original four largest TOOLS disks.  These are the IBMPC and
IBMVM conference disks, and their corresponding tool (program) collections,
PCTOOLS and VMTOOLS.
%
Big OS:  (big ozz) n. Operating System/360.  This term was popular in the
late '60s when "OS" was the operating system, and it was believed to do and
know everything.
%
Big Red Switch, BRS:  1.n. A device for removing the power from (and
sometimes restoring it to) a computer.  Originally (1973) used to refer to
the Emergency Power Off switch on System/360 machines; now mainly used to
refer to the PC or PS/2 Power On/Off switch.  [Which, in the usual way of
things, is no longer red on the most recent machines.] On this machine, it is
commonly used to reset the machine when everything else fails to bring the PC
software back into a usable state.  Using the BRS is also called "power
cycling".  See also Poughkeepsie reset, blue button.  2. v. To reset or
restart electrical machinery by raising the On/Off switch (the Big Red
Switch) to the Off position and then returning it to the On position again
[or vice versa, down to the Off position, depending on the country of origin
of the machinery].  As in "If Alt-Ctrl-Del doesn't work, you'll need to BRS
it".
%
Boca:  n. Short for Boca Raton, the Fatherland of the PC (and a favourite
venue for business meetings during first quarter).  It should be noted that
most of the buildings in that area are in fact in Delray Beach.  Also note
that Boca Raton (the mouse's mouth) got its name from the pirates who
harboured there, because of the safety afforded by the dangerous reefs in the
channel.  [Note raton seems to be the Spanish for "mouse", not "rat" (which
is rata).]
%
Boca West:  n. One of the IBM locations at Austin, Menlo Park, or Tucson.
The actual designation varies from day to day depending upon the mood at the
headquarters of the Entry Systems Division.
%
Bookie:  n. The familiar name for BookMaster, a document-formatting product
based on the ISIL tool (which was used for producing most IBM publications
before it became Bookie).  [You bet it looks nice!] This nickname came about
not only because it's shorter than the real name, but also because one of the
names originally proposed for the product was "BookMaker".
%
Bubblegum:  n. The Boeblingen Laboratory, in Germany.  Americans have four
alternatives in trying to pronounce "Boeblingen" a) BO-BLING-GEN makes you
sound as if you have never heard the word spoken and are clearly "out of it";
b) BER-BLING-GEN (the most popular variant) sounds as if you KNOW what it
sounds like but cannot pronounce it yourself (probably true); c) BOB-LING-GEN
seems to be a favourite in New York State; d) the correct pronunciation
leaves you open to accusations of intellectual snobbery by the other groups.
Calling it "Bubblegum" defuses the whole issue by attempting to make it a
joke.
%
Bunch:  n. When RCA and General Electric dropped out of the computer
business, the Seven Dwarves became the rather less romantic "Bunch".
(Burroughs, Univac, NCR, Control Data, and Honeywell).  In 1986, this
grouping changed again due to the merger of Burroughs and Sperry-Univac to
form Unisys - no follow-on to the term seems to have arisen.  [Not to be
confused with Baybunch - the San Francisco Bay IBM user group.]
%
Burlington South:  n. The East Fishkill location, in New York State.
%
C-word:  n. Confidential.  This alternative is used to avoid triggering
automatic disk snooping programs that warn of possible security exposures
when they detect the string IBM Confidential on an unprotected disk.  "This
is not an IBM C-word document".
%
CCITE:  (see-sight) n. Cooperative Computing Internal Technical Exchange, an
internal conference that focuses on the cooperation of different operating
systems in performing computing tasks.  The first CCITE was held in 1989 at
the Almaden Research Center.  It replaced, and follows in the traditions of,
the VMITE conference.
%
CI to C:  n. The standard "just list" wiring on programmable accounting
machines.  See all cycles to list.
%
CLIP:  (klip) v. To change the (magnetic) pack label on a DASD volume (disk
pack).  The term CLIP stood for Change Label Information Program.  Usually
IPL'd from cards, this program not only changed the serial number but also
other items in the volume label area.  These other capabilities were seldom
used, so CLIPping became synonymous with changing the volume serial number.
%
COBOL programmer:  n. A person whose experience is limited to commercial
applications programming.  This term, now rare, had negative connotations.
COBOL is not highly regarded in IBM; few people in IBM choose to program in
the language.
%
CRU:  (crew) n. Customer Replaceable Unit.  Part of a device (such as a
keyboard) that is considered to be replaceable by a customer or end user.
(Fix it yourself.) See FRU.
%
CSR:  n. Customer Selected Restaurant.  A good [or, at any rate, expensive]
restaurant.  This term is used heavily in expense claim forms to explain why
a person found it necessary to eat at the most expensive restaurant in town -
the rationale being that if the customer one is dining with suggested it, one
could hardly refuse, could one?
%
CYA:  (see-wye-ay) v. To protect one's rear.  This protection is typically
effected by generating documents of understanding, obscure memos, PROFS mail,
and the like, which will prove (if necessary) that the author knew all along
that the project was doomed to failure.  Variously estimated to consume
between 71% and 78% of all managerial resources at most development labs.
See MFR.
%
Cave of the Winds:  n. The Divisional HQ at 1133 Westchester Avenue, White
Plains, New York.  The term refers to the famous cave of the same name, and
arose because of the poorly designed air-conditioning system installed when
the building was constructed.  The building is divided into three parts - a
long centre section and two ends.  Each part had its own air circulation
system (for heating and air-conditioning), and as a result there were
pressure differentials relative to the outside - and between the various
parts of the building.  There were large doors in the one aisle that connects
the different pieces, and pressures were equalised through these doors.
Offices near to the doors were most undesirable due to the whistling of the
winds, and small people sometimes had trouble opening the doors against the
suction.  The name for the building has stuck, now because of all the hot air
alleged to circulate spontaneously therein.
%
Chad Age:  n. The prehistory of computing [prior to 1975].  This is the dawn
of the computer era, so called from the myriads of fossilised small pieces of
paper or cardboard (chad) found in geological strata dating back to the
fifties and sixties.  Those remains were left by one of our ancestors, the
Homo Ibeehemerus Nuyorckus, whose major dwellings can still be located along
the Hudson River Valley.  A reader recounts that in 1976 he worked in a U.S.
Navy message center that was still using paper tape for all its traffic
(thousands of messages a day).  They used several colours of paper tape,
representing the various classifications of the messages.  A common trick to
play on newcomers was to have them separate classified chad from unclassified
chad - since all classified materials had to be burned.
%
Charlie letter:  n. An announcement letter for retail dealers of IBM Personal
Computer equipment.  This refers to Charlie Chaplin, a comic actor whose
portrayal of a tramp was copied in IBM PC advertisements, much to the delight
of satirists.
%
Corporate:  n. Any hierarchical level sufficiently high that it impresses
opponents and quashes their arguments.  As in "These rules come from
Corporate".  [Now (1990) gradually being replaced by "top of the business".]
See also edict.
%
DASD:  (dazz-dee) v. To place on a computer disk (Direct Access Storage
Device), as in "Please DASD that report when you've written it".  DASD
storage implies storage on a disk connected to a large mainframe computer,
rather than on the hard or soft disks in a Personal Computer.  It also
implies magnetic storage; an optical disk would not be described as DASD.
%
DEBE:  (debbie) 1.n. "Does Everything But Eat" - a general 360/370 utility
for moving data from device to device.  Originally a stand-alone program
(i.e., it did not require an operating system) named after the niece of its
author.  It is an example of the human interfaces provided by programs in the
1960s (it's sad to see how little the industry has progressed in twenty
years).  2. v. To try as a last resort.  "Nothing else works; let's DEBE it".
%
DWIM instruction:  (like swim) n. "Do What I Mean".  This is a mythical
instruction invoked by a frustrated programmer to give acceptable results
when in fact he could not define what he meant (but would recognise it if he
saw it).  Also invoked when the last instruction issued to the machine was
disastrous "Do what I mean, not what I say, you dumb machine!" In LISP
environments, the DWIM instruction is often simply a mechanism that randomly
rearranges parentheses.
%
Disneyland East:  n. The headquarters building on Westchester Avenue, White
Plains (see 1133 below).  This term gained such widespread use that several
years ago a middle manager (who later became a very senior marketing manager
and wrote a book about his experiences) actually sent out a memo forbidding
its use.
%
Divisions:  1.n. Any IBM locations outside New York State, or north of
Interstate 84, or west of the Hudson River.  2.n. A derogatory term used at
Yorktown Research to describe the rest of IBM.  "That idea came from the
Divisions".  See also NIH.
%
Domestic:  adj.  Those parts of IBM that are located in the USA.  Used by
U.S. IBMers to imply all that really matters in IBM.  Used almost universally
by everyone else to describe an insular (provincial) approach to a problem.
"He's Domestic - thinks everyone speaks American".  See also nonus.
%
Doughnut City:  n. Basingstoke, Hampshire (a town with a rapidly growing IBM
presence).  So dubbed for the large number of roundabouts (traffic circles)
encircling the town.  [This term predates the IBM usage.] It was conjectured,
and came to pass, that as more and more IBM personnel were moved there a verb
was created, as in "I have now been doughnutted" - re-located to Basingstoke.
[Both friends and relations of mine believed not that Basingstoke had an
existence other than in Ruddigore.]
%
EBCDIC:  (ebb-sidick, ebb-see-dick) n. The Extended Binary Coded Decimal
Interchange Code.  This code for characters was designed in the early 1960s,
as an extension of the BCDIC to take advantage of the 8-bit byte being
introduced for the System/360.  The most notorious of its idiosyncrasies
(that the primary English alphabet is not a series of contiguous codes) is
ultimately derived from the Hollerith code for punched cards.  See also ASCII
bit.
%
EC:  1.n. Engineering Change - a hardware update.  A formally announced fix
or enhancement to a piece of hardware, usually required to support later
(unforeseen) products.  "Before you can run the new level of system with this
box, you must apply EC-58320 to all your control units".  2.n. Extended
Control - a privileged or enhanced state of control over a piece of hardware.
If, for example, a person is running an MVS system under VM/SP, then that
person's virtual machine has to be in EC mode, and is said to be "running
EC".  -ed (suffix to a surname).  Subjected to unnecessary troubles due to a
person's inconsideration or paranoia.  As in "I've been Smithed".  The suffix
can also be added to the name of a program or utility, and in this case
implies that the user has suffered abuse at the hands of said program "I've
been MSGed to death by our network machine".
%
EMEA:  n. Abbreviation for "Europe, Middle East, Africa".  The division of
IBM that includes all the country organisations in the designated
geographical area.  That is, most of the high growth areas.
%
EPL:  (ee-pee-ell) n. The European Program Library (since 1987 called the
Software and Publications Centre, or SPC, but still commonly known as EPL).
The European equivalent of PID, and even more inscrutable.  Availability from
EPL is always at least one month later than from PID, except when a program
product is developed in Europe and sent to EPL first.
%
EREP:  (errep, ee-rep) v. To take a snapshot of an error log or trace.  From
Environmental Recording Editing and Printing, a program for printing a
formatted log of hardware and software error conditions on System/360 and
System/370 machines.  Also used (as a noun) to designate the output of such a
program.  EREPs, like dumps, are "run" or "taken" (other listings are usually
"printed").
%
ESP:  (esp, ee-ess-pee) 1.n. Early Support Program.  A procedure by which
certain members of the lunatic fringe - both internal and external - are
given versions of a product after announce but before FCS.  The object of the
exercise is to get the bugs out of the product and confirm its ease-of-use
without creating too many account situations.  Also called LA (Limited
Availability), though there are some slight differences.  See also GA.  2.n.
Extra Sensory Perception.  The technique by which ESP (1.) users learn the
details of the product in the absence of any knowledge on the part of the
support staff or of any documentation.  3. v. To ship the ESP (1.) version of
a product to the brave volunteers that will try it.  4. v. To install a new
version of a product before anyone else.  "Our Compute Centre folks are very
progressive, they ESPed SP4".
%
ETN:  adj.  Equivalent To New.  Of computer parts used somewhere (and
therefore burned-in) and hence, after testing, more reliable than new parts.
[So it is hoped.]
%
Endicott suitcase:  n. A corrugated cardboard box with a suitcase-like
handle.  These were issued to students leaving Marketing Training classes
(which originally were held at Endicott) for transporting class materials
back to their home location.
%
Europe:  n. That part of the (IBM) world that consists of Israel, South
Africa, and the European countries - excluding parts of the Eastern Bloc,
Albania, and Libya.
%
FAP:  n. Financial Assistance Program.  A programme originally offered to ESD
(Entry Systems Division) employees, whose job disappeared as a result of PS/2
manufacturing moving from Boca Raton to Raleigh, and later extended.
Employees who took advantage of the original FAP resigned from IBM, and
received a golden handshake of two years salary plus a bonus.  This led to
such expressions as "Taking the FAP", "Faphappy", and "Are you going to fap
or flap?".
%
FBC:  n. Funny Black Connector.  The hermaphroditic connector used in the
cabling system.
%
FCS:  n. First customer ship.  The time at which products are first delivered
to customers, usually cause for celebration.  ("Pub Time".) This is also the
time at which FE starts fixing the bugs that were discovered too late in the
development cycle to be corrected.  See also announce, ESP, GA.
%
FISH:  (fish) n. A queuing algorithm that seems to be common in overloaded
networks "First In, Still Here".  By analogy with FIFO (First In, First Out)
and LIFO (Last In, First Out).
%
FLOP:  (flop) n. Floating Point OPeration, more usually seen in the construct
Megaflops (Millions of Floating Point Operations per Second), a measure of
performance usually applied to scientific vector processors.  The
abbreviation FLOP has the added advantage, in the commercial world, of
sounding slightly derogatory.  See also MIPS.
%
FRU:  (frew) n. Field Replaceable Unit - a unit that is the smallest
replaceable in the field (i.e., outside a factory or reconditioning plant).
A complete logic card might be a FRU, but a chip permanently mounted on a
card would not be.  See also CRU.
%
FS:  n. Future System.  A synonym for dreams that didn't come true.  "That
project will be another FS".  Note that FS is also the abbreviation for
"functionally stabilized", and, in Hebrew, means "zero", or "nothing".  Also
known as "False Start", etc.
%
FUD:  (fud) n. Fear, Uncertainty and Doubt.  Attributed to Dr. Gene Amdahl
after he left IBM to start his own company, Amdahl, who alleged that "FUD is
the fear, uncertainty and doubt that IBM sales people instill in the minds of
potential customers who may be considering our [Amdahl] products".
%
Fall Plan:  n. A plan, adopted in the autumn of each year, that describes the
future commitments and business of a location or division.  [Now known as the
Commit Plan.] This is preceded by a period of three months during which most
productive work stops for a general free-forall over which projects are to be
considered strategic.  The plan, once adopted, is ignored.  See Spring Plan.
%
Finnoga-:  prefix.  A generic prefix used to avoid using a Registered Trade
Mark prefix and thus being admonished by Legal because you forgot to add the
mandatory Trade Mark footnote.  For example FinnogaCalc, FinnogaWriter,
FinnogaBase.  See also Panda-.
%
Flashcube on the Mountain:  n. The Sterling Forest Laboratory, New York.
This name was a take-off on the "Motel on the Mountain" which, in the 1950s,
was a fashionable motel on Route 17 in NY (not far from Sterling Forest).  In
an era when motels were cheap buildings alongside noisy highways, this was a
nice "low level" hotel.  It was built into the side of a mountain and had
multiple small buildings of several different levels, and many of its rooms
had nice views.
%
Foil Factory:  n. IBM Australia's Headquarters at Cumberland Forest, New
South Wales.  See also Koala Park.
%
Fort Apache:  n. Building 300, East Fishkill.  The term derives from the
shape of the building, whose second storey overhangs the first.  The term is
also applied to Building 707 in Poughkeepsie, where the windowsills are
sloped at 45 degrees so that despairing managers will not hurt themselves or
damage the building while going out of the windows.
%
Fort Cottle:  n. Building 026, San Jose.  A large, boxlike building with
gun-slit windows located at the Cottle Road site at San Jose.  This building
is considered by many to be unfit for human occupancy, and has largely been
given over to computers.
%
Frank:  n. The chairman of the board in the late 1970s Frank Cary.  "If you
don't like it, go talk to Frank".  The term is still used to refer to the
Exalted Ones At The Top.  (The current correct term would be "John", but this
has not found wide usage.)
%
Fred:  n. A generic name for files, userids, etc.  in examples.  See also
Panda-.
%
Frozen Zone:  1.n. The period between December 15th and January 15th during
which no upgrades should be made to the company's systems, to allow users to
finish their yearly reports.  However, major bugs are usually found during
this period, due to the higher-than-usual activity, and, of course, many
machines have to be installed before December 31st to avoid being debitedon
the next year's budget...  2.n. The period, normally at the beginning of a
year, in build-to-plan ordering of a product when no further changes in
quantities can be made by the manufacturing plant.  For example, if a sales
area requests an increase in the shipments of a BTP product, the plant may
well respond that "it's in Frozen Zone - no can do".
%
GA:  n. General Availability.  The time at which product is available (at
least within one country) to anyone who wishes to buy it.  This may be later
than FCS if there has been an ESP.  See also announce.
%
GML:  1.n. Generalised Markup Language.  A language used for marking up
documents (such as this one) to show the structure and organization of the
document, rather than its appearance.  The concepts and syntax of the
original IBM GML have been generalised to form the ISO Standard GML (SGML).
2. v. To annotate a document with Generalised Markup Language.  "I've GMLed
the document so anyone can print it".
%
GMT-friendly:  adj.  Of a computer system having a CPU clock which is
correctly set to GMT, hence allowing coordinated interchange of timing
information with systems in other time-zones.  If one exchanges information
with a user on a GMT-hostile system, one may receive files that appear to
have been created at some time in the future.  The future, of course, is up
to 25 time-zones away and travelling towards you.
%
Galactic Headquarters:  n. The old IBM building in New York City at 590
Madison Avenue.  This was occupied by Corporate Headquarters before they
moved to Armonk.  It was distinguished by the old IBM logo on the front,
which was a globe with the words "World Peace Through World Trade" on it.
(This building has since been demolished, and has been replaced by a new
building, also owned by IBM.) The term "Galactic HQ" now generally refers to
the Armonk location.
%
General Availability:  n. The time when a product is scheduled to be
available in quantity.  The sequence announce - ESP - FCS - General
Availability normally applies, but the exact mix varies according to the type
of product and the skills of the product planners.  In some cases, FCS and
General Availability are synonymous.  See also customer ship.
%
Gor:  n. A non-specific place name.  From the titles of a series of "science"
fantasy novels by one John Norman (John Frederick Lange).  It was first used
in IBM in the names of "generic" PC adventure games, such as "Giant Rabbits
of Gor", but has since spread to other environments.
%
Great Oral Tradition:  n. The explanation for why so many pieces of widely
used, basic, or important information are not to be found recorded anywhere,
despite the existence of several forests' worth of manuals and Gigabytes of
on-line documentation.  One theory holds that since widely used information
should be intuitively obvious to newcomers to the corporation, writing it
down is a waste of time.  In addition, such material is in a constant state
of flux, which only reinforces the argument of the futility of documentation.
[Perhaps this poor dictionary will continue to help those in such need.]
%
Great Runes:  n. Expressions using only uppercase characters.  Nowadays used
mostly by megalomaniac operating systems and compilers, and by users
discovering their very first desk-top publishing system.
%
HOBit, hobbit:  (hobbit) n. High Order Bit; the most significant (leftmost)
bit in bit-organised data.
%
HONEhead:  1.n. One of a select few in the Branch Office who, through the use
of the office HONE (Hands-On Network Environment) terminal, can always find
the answer to even the most obscure question.  The first symptom usually
noted is frequent missing of lunch to scrounge for new Product announcements
on the system.  Hard cases have at least one userid on every HONE machine in
the network.  2.n. A member of the HONE system support staff who believes
that the answer to every question should be on the HONE system, and that
there should be a minimum of five menus associated with finding any answer.
%
Hall of Winds:  n. See Cave of the Winds.
%
Hudson River Valley Works:  n. IBM.  Much of the Hudson River Valley, in New
York State, is influenced by IBM.  There are major IBM locations throughout
Westchester County, and at East Fishkill, Poughkeepsie, and Kingston.
%
IBM:  1.n. International Business Machines.  [In case you really didn't know;
many don't.] 2.n. A hypothetical 370 instruction, existence strongly
suspected but not yet proven "Insert Bug under Mask".  3. n. Immense Blue
Mountain (or Monolith).  4. n. I've Been Moved, alluding to the favourite
game of departmental and divisional reorganisations.  5. n. It's Better
Manually.  6. n. Hudson River Valley Works.  Much of that valley, in New York
State, is owned by IBM.
%
IBMJARG:  n. A document which lists numerous "jargon" terms used within IBM.
(This document.) See also recursive.
%
IBM Confidential:  adj.  Only accessible to IBM employees who can claim a
need to know.  This may be proprietary information relating to personnel or
technical matters, or information that could be embarrassing to IBM.  See
also candy-striped, Poughkeepsie Confidential, Registered IBM Confidential.
%
IBM Internal Use Only:  adj.  Proprietary to IBM, but may be shown to (but
not left with) non-IBMers.  Sometimes, information that is confidential but
which the classifier does not wish to, or cannot, keep locked away.
%
IBM discount:  n. A price increase.  This term is said to have been coined in
Poughkeepsie, and refers to the belief that residents in an area with a large
IBM population end up overpaying for goods and services.
%
IBMer:  n. An employee of International Business Machines.  See also Beamer,
Beemer.
%
IBMois:  (ee-bay-aym-wa) n. A strange French dialect spoken mostly around
Paris, Nice, Bordeaux, and Montpellier.  Although it bears some relationship
to Franglais, it goes a step further by using French words with an improper
meaning (addresser, delayer, eligible...). Note also that some of those words
are often misspelt from the French (addresser should be adresser, for
instance).
%
IC:  (eye-see) n. Information Centre.  No, not Integrated Circuit!  Since
Information Centres replaced the DP shop as the place to go for programming
assistance, it has been decreed that "IC" no longer means "integrated
circuit".
%
IEHIBALL:  (eye-ee-aitch-eye-ball) n. A data compare/scanning utility to be
used when all the normal utilities prove to be inadequate.  For example, "The
only way to check that is to run it through the IEHIBALL utility".  [This is
a pun, based on the observation that the names of many OS utilities start
with the prefix "IEH".]
%
IHR:  n. In-House Retiree.  Hudson Valley variety of IPR.
%
IPL:  (eye-pee-ell) v. To Initial Program Load.  To restart "from square one"
after an operating system has crashed.  Used to indicate starting anything
from scratch, as in "She IPLs on coffee each morning".  Also IMPL (Initial
Micro Program Load - now an obsolete term), or IML (Initial Microcode Load).
IML was originally known as "Initial Minnow Load", Minnow being the code name
for the floppy disk drive on the 370/145 computer.
%
IPR:  (eye-pee-are) n. In-Plant Retiree.  Someone who has stopped doing any
visible work, but has not done anything wrong so cannot be fired.  In the
Japanese vernacular this is a "person with a window seat" or a "newspaper
reader".  When it was difficult to to fire an employee who had retired in
place, they were "assigned a window seat" to get them out of the way.  In one
sales office this usage caught on, and over time the adage to "lead, follow
or get out of the way" evolved into "lead, follow or catch some rays".  Not
to be confused with intellectual property rights, another (1985) meaning for
the abbreviation.  See also ROJ, gold-coaster, IHR.
%
IPV:  (eye-pee-vee) n. Intra-Plant Vacation.  This is usually a long walk
around the work location (plant) to let tempers cool and common sense
prevail.  Usage "I think I'll go take an IPV".  [This is also used as a verb,
but such usage is likely to be misunderstood.]
%
IS:  (eye-ess) n. Information Systems.  The department that manages the
computer installations at many IBM sites.  Optimists thought it stood for
"Information Services" until they became users.
%
I didn't change anything:  interjection.  "Something has changed but I have
no idea what".  Also I didn't change a card.  Plaintive cry preceding
feelings of the cold pricklies.  The proper reply to this cry is "Then it
works just the same as it did before, right?" See also one-line fix.
%
Information Asset Security:  n. The protection of ideas, programs,
information, and inventions.  Also used (usually as the abbreviation IAS) to
refer to the people involved in enforcing this protection.  See security.
%
Information Support Staff:  n. A group of people alleged to exist in various
locations to help other IBMers actually get computer access.  A rule of thumb
if the telephone number is published, then whoever answers will most likely
be unable to help.  (There is a general truth here someone with real skills
will have moved on to something better.  And will not publicise his or her
telephone number as then it would be impossible to get any work done.)
%
Interim Plan:  n. Two Interim Plans (Summer and Winter) are placed between
the Spring Plan and the Fall Plan.  These plans are timed in order a) to
review and refine the hurried results of the previous Spring or Fall Plan, b)
to add project items "forgotten" in the previous plan (now that no one is
looking), and c) to ensure full employment of the bureaucrats responsible for
devising the plans.
%
Iron Mountain:  n. Permanent "vital records" document storage.  "We'll send
these files to Iron Mountain".  Originally, a vendor specialising in securing
backup documentation against nuclear attack; now any archival storage.  Not a
good place to put data you ever want to use again.  See also Wansdyke, Salt
Mine.
%
Ivan Fredin Expressway:  n. The series of corridors that connect buildings at
the Endicott Plant at the third floor level.  One can cover more than 600
meters in a straight path running through seven buildings; it can take 20
minutes to walk from one end to the other.  Ivan Fredin was the Endicott
Plant General Manager in the 1960s.
%
JCL:  n. Job Control language.  This was one of IBM's earliest attempts to
make computing easy - JCL has only five command verbs.  Unfortunately, one of
these verbs has grown to have at least 192 different modifiers.  [Probably
200, by the time you read this!] See command language.
%
JESplex:  (jezz-plecks) n. Another word for CEC, the central electronics
complex of olden days.  JES stands for Job Entry Subsystem.  This is heard
frequently on Myers Corners Road, in Poughkeepsie, where some people still
fondly believe that all mainframes run the MVS/JES operating system.  (In
fact, it's fewer than half.)
%
KIPS:  (kips) n. Thousands of instructions per second.  Derivative of MIPS.
See also kipper.
%
KISS Principle:  n. "Keep It Simple, Stupid".  Usually quoted when developing
a product in restricted time, e.g., due to marketing pressures.  Not usually
adhered to by software development teams, once the first release has been
shipped.  This usage is distorted (or vice versa) from the marketing
guideline "Keep It Short and Simple", intended to hone presentations.
%
KLOCY:  (kay-loc-year) n. Thousands of lines of code times the number of
years that the code has been in use.  A measurement used in estimating
service workloads.  See k, line of code.
%
Katzenbox:  n. A corrugated cardboard records box (approximately 280mm by
305mm by 400mm).  These once had "IBM" printed on all four sides, but now
only have print on one end, stating DIV NO., DEPT NO., and BOX NO...  OF...
The name originated in January 1969 when the U.S. Government brought
antitrust charges against the IBM Corporation claiming that IBM had a
monopoly in the data processing industry.  Thereafter, tons of papers
purported to show the way IBM conducted business in the USA had to be stored
as evidence by order of IBM's chief counsel Nicholas deB.  Katzenbach.  The
boxes are now used mainly for moving possesions between offices, or for
permanent temporary storage.  Also Katzenbach box.
%
Kenmore Card:  n. The first edition of the System/370 Extended Architecture
Reference Summary, which had its title laid out so it accidentally spelled
out "SEARS".  "Kenmore" is the brand name for a number of Sears' products.
%
King Kong:  adj.  Of a program large, unwieldy, and bug-infested.  See also
Mickey Mouse.
%
Koala Park:  n. IBM Australia's Headquarters at Cumberland Forest, New South
Wales.  A reference to a wildlife sanctuary about a kilometre away.  Koalas'
most favoured occupations are eating and sleeping.  See also Foil Factory.
%
LSD:  n. An abbreviation used (in Marketing Education classes) to refer to
improper behaviour on business premises.  Stands for Liquor, Sex, and Drugs.
The LSD lecture usually comes in the second week of the first marketing class
in Dallas.  One happy anecdote refers to this item "In 1964 my first manager
was lecturing me about the proper conduct of an IBMer (not that I especially
needed it).  Referring to the `S' of `LSD', he said that this sort of
activity was `forbidden on company time or furniture'".  [So where do little
IBMers come from?]
%
Legal:. The local legal department (now usually given a grander name).  As in
"Better pass that by Legal before using it!"
%
Lookie:  n. The familiar name for BookManager, an online document
consultation product that provides documentation in softcopy form.  By
analogy with Bookie.
%
MFR:  n. Memorandum For the Record.  A generally secret broadside against
some other party, which rationalises one's own position for posterity in
local files.  Where heavily used, the accumulated collection forms a
remarkable work of fiction.  MFRs are favoured CYA items since there is no
possibility of refutation.
%
MIP-burner:  n. A long-running program.  A derogatory term used to describe
any piece of software that takes, or appears to take, more time to accomplish
something than the end result would seem to justify.  Also used to describe
any piece of software that responds slowly to requests.
%
MIP-eater:  n. Any program that uses more than 10% of a shared CPU on behalf
of a single user.  Corrupt usage - it should of course be "MIPS-eater" (see
MIPS).
%
MIPS:  (mipps) 1.n. Millions of Instructions Per Second, a measure of
processor speed.  Though often used, the term "1 MIP" is incorrect.  ("One
Million Instructions Per..". What?  Year?) 2.n. Misleading Indication of
Processor Speed.  See also cycles, throughput.
%
MIP envy:  n. The term, coined by Jim Gray in 1980, that began the Tandem
Memos.  MIP envy is the coveting of other's facilities - not just the CPU
power available to them, but also the languages, editors, debuggers, mail
systems and networks.  MIP envy is a term every programmer will understand,
being another expression of the proverb "The grass is always greener on the
other side of the fence".
%
MSG:  (message) v. To communicate via a computertransmitted message, rather
than by telephone.  Usage "MSG me when you are ready to go to lunch".
%
MSSB:  n. Multiple Suppliers Systems Bulletin.  A memo used as a scare tactic
on customers rash enough to try using a non-IBM component in an IBM system or
network.  It is said that once one was issued to a UK customer who tried (and
failed) to link an IBM mainframe host to an IBM office device using IBM
modems.  The story goes that the IBM response to the problem was that the 20
metres of wire linking the two modems was not IBM provided.
%
MVM:  n. Multiple Virtual Memory.  The original name for MVS, which fell foul
of the fashion of changing "memory" to "storage".
%
MVS:  1.n. Multiple Virtual Storage, an alternate name for OS/VS2 (Release
2), and hence a direct descendent of OS.  [OS/VS2 (Release 1) was in fact the
last release of OS MVT, to which paging had been added; it was known by some
as SVS (Single Virtual Storage).] MVS is one of the "big two" operating
systems for System/370 computers (the other being VM ). 2.n. Man Versus
System.
%
Mainframe City:  n. Poughkeepsie, New York.  Where most of IBM's large
computers (mainframes) are designed.
%
Maytag mode:  n. The behaviour exhibited by an 8809 tape drive in streaming
mode, when attached to an inadequate or distracted CPU.  The continuously
backtracking horizontal reels uncannily resemble washing machine agitators;
the 8809's "top-loading" configuration just strengthens the analogy.  The
term sees common but clandestine usage in some Customer Support Centers.
["Maytag" is the brand name of a washing machine (and other white goods)
produced in the USA and known for their reliability.]
%
Meg:  n. Megabyte.  As in "This program needs two Meg to run".  "Meg" does
not usually have a different plural form.  See m, M.
%
Mickey Mouse:  1. adj.  Of a program expected to be small, easy to write and
usually of only temporary importance.  For example, a program to fix an error
in a data file caused by a bug in another program.  Naturally, Mickey Mouse
programs tend to last longer, get bigger, and in their turn do more damage
than the official programs written in the first place, thus turning into King
Kong programs.  Use of this term is inadvisable in the Emerald Isle
[Ireland].  See also toy.  2. adj.  Unnecessary.  Used when complaining about
bureaucratic harassment, as in "not another Mickey Mouse form to fill in!"
%
Minnow:  n. A floppy disk used for the initial loading of some System/370
computers.  See IPL.
%
Model A:  n. An A-Box.  This term is sometimes used for the person most
trusted by a project manager [right-hand person?].
%
Moletown:  n. The Yorktown Heights location (the T. J. Watson Research
Center).  A reference to the observation that none of the offices or
laboratories there have windows.  The disease spread to Poughkeepsie and was
there incorporated in the 1982 Office Design Standard.  See also outside
awareness.
%
Mongolian Hordes Technique:  n. A software development method whereby large
numbers of inexperienced programmers are thrown at a mammoth software project
(instead of deploying a small team of skilled programmers).  First recorded
in 1965, but popular as ever in the 1990s.
%
Mud Flats:  n. The Myers Corner Laboratory, near Poughkeepsie.  From the
geography of the land on which it was built.  See also Orchard.
%
NIH:  (en-eye-aich) adj.  "Not Invented Here" or "Not In-House".  A hatred of
anything new, sometimes almost classifiable as misoneism.  Possibly more
common inside IBM than outside, though of course IBM's house is larger than
most.  Also NITT (nit) Not Invented in This Tower.  See also nonus.
%
NOSS, nossage:  1.n. A message sent using the UK NOSS network.  NOSS is the
IBM UK National Office Support Service, which is based on VM systems running
PROFS.  "I'll be out of the office tomorrow, can you send me a NOSS on it?"
2. v. To send such a message.  "I'll NOSS you on that later".
%
NUCON:  (new-con) adj.  Originally a CMS term for the NUcleus CONstant area,
a static area in System/370 addressing page zero.  Now also used to describe
a programmer who will not (or cannot) write re-entrant code "He has NUCON
mentality".  See nucleus.
%
Nasty and Cold Division:  n. The North-Central Marketing Division.
(Alternative expansion of the abbreviation.) See also Sunny and Warm
Division.
%
Nathan Hale:  n. An asterisk ("*").  Reportedly from Nathan Hale's remarks
before being hanged "I regret that I have but one asterisk for my country".
Usage prevalent only among those with a Neu Yawk or Noo Joisey accent, for
various and obvious reasons.  [Nathan Hale was a (failed) spy involved in the
American War of Independence.]
%
National Language Support:  n. Support for any language other than American
English.  The phrase National Language Enabled is loosely used to describe
any program for which more than a few seconds of thought have been spent in
considering the problems of making it work successfully in environments other
than the USA.  See also Domestic, nonus.
%
Nice To Have:  n. A good idea, but not absolutely necessary.  Usage "That
enhancement seems to me to be a Nice To Have, but how does it bring extra
revenue?" See also business case.
%
Non-D:  (non-dee) n. Non-Disclosure agreement.  A document, often a "letter
112", which an IBMer or customer signs to acknowledge the receipt of
proprietary information and to promise not to pass on the information to
anyone else unless they too have signed an appropriate Non-D.
%
OCO:  (oh-see-oh, occo) adj.  Object Code Only.  A product that is OCO is
shipped with only the Object Code (the text files produced by compilers).
The original source code (often in IBM's internal systems programming
language, PL/AS) is not provided.  This is partly because no PL/AS compiler
is available as a product - as any IBMer who has to write code for customers
is painfully aware.  Customers with an MVS background (who have never had
source code) see this as "business as usual".  Customers who use VM see this
as a totally unacceptable way to do business.  "We want to fix it in the
language it broke in".
%
OEM:  (oh-ee-em) n. Original Equipment Manufacturer, a manufacturer who makes
a fundamental sub-assembly that others use to build a more complex product.
Inside IBM it means "Other Equipment Manufacturer".  See vendor.
%
OEMI:  (oh-emmy, or oh-ee-em-eye) adj.  This is used to precisely identify
the System/370 channel to control unit interface (also still known by the
name FIPS60 - a standard which is at least 10 years out of date).  The word
is derived from the channel to control unit interface OEMI Manual
(GA22-6974), in which OEMI means "Original Equipment Manufacturer's
Information".  (The "I" in OEMI is often misconstrued to mean "interface";
however, "interface" is defined by the United States Supreme Court to mean a
physical place where Other Equipment Manufacturers are legally entitled to
attach their "Plug Compatible Units".  Fortunately for 95% of the world's
population, this particular ruling is limited by jurisdiction.)
%
OS:  (oh-ess, oss) n. Any of the operating systems MVS/XA, MVS, SVS, MFT,
MVT, or VS1.  These operating systems all grew from "OS/360", the first
widespread 360 Operating System.  The term OS excludes such operating systems
as CP/67, VM/370, VM/SP, VM/XA, TSS, RASP, and ACP.  See also Big OS.
%
October Revolution:  n. The 1986 reorganisation of IBM France.
%
Opel letter:  n. A Speak Up!  sent to the highest levels of the Corporation.
Sometimes seen as opal letter.  As in "If he tries to pull that on me, I
swear I'll write an Opel letter about it".  [The term does convey a vague
luminescence, no?] This term may or may not be replaced by the phrase "Akers
letter".
%
Orchard:  n. The Armonk location.  Corporate Headquarters was built on the
site of an apple orchard (hence the address Old Orchard Road, Armonk, NY
10504).  Some fruit trees still remain, but it is understood that they have
been chemically treated to produce flowers but no fruit.  This condition is
perhaps known as appellation controlee.
%
Overhead Row:  n. The most plush office corridor in a location.  This houses
the head person (and entourage), whose true power (or ambition) may be gauged
by assessing the quality of the wood furniture, the depth of the carpet, and
the rarity of the potted plants.  Owego (oh-wee-go) See branch to Owego.
%
PC:  (pee-cee) n. The IBM Personal Computer.  In order to discourage the
persistent innovators who suggested that IBM build yet another desktop
computer, they were told to bring it from conception to production in less
than a year.  The result was one of the most visible (but not the most
profitable) successes since System/360.  The very unfortunate choice of
processor hinders the competition just as much as IBM, but even so the effect
of standardisation has been of considerable benefit to those using the
machine (or one of its many copies).
%
PDB:  n. Pastel Denim Binder.  One of the few pieces of truly IBM jargon
associated with the IBM Personal Computer.  Refers to the boxes and binders
in which the documentation for the PC is shipped.  May be almost any colour.
peach letter See blue letter.
%
PF4:  v. To erase, or destroy.  This is derived from the usual effect of
pressing the hardwired "Program Function key number 4" when running PROFS.
As in "Yeah, I got that request and I PF4'd it!" Note that PF4ing in PROFS
only erases the working copy of a document; it does not erase backup or other
copies of the document.
%
PID:  (pid) adj.  The version of a program as shipped to customers.  From
Program Information Department.  This department is no more, having been
replaced by ISD (IBM Software Distribution) and then SMD (Software
Manufacturing and Delivery) but the term PID is still very widely used.
"These days, we have to run the PID version".  See vanilla.
%
PID buffer:  n. A period of approximately three weeks during which a software
release matures while at PID.  This provides a convenient breathing space
during which the developers can discover problems before the software is
shipped.
%
PITS:  (pitz) v. To register a problem on the Problem Information Tracking
System.  PITS is an ad hoc database system, developed at the Glendale
Laboratory at Endicott, that is used for tracking problems during software
development.  "That looks like a real bug; you had better PITS it".
%
POO:  (pooh, as in Winnie-the-) n. Principles Of Operations.  See POP.  This
acronym was used extensively in FSD (Federal Systems Division) and elsewhere
in the late 1960s and early 1970s but is less often heard since then -
probably because so few now write programs in assembler.  Also mini-poo for
the green card.
%
POP, POOP, POPs, p.ops:  (pops) n. The manual that defines the principles of
operation of the System/360 (and, later, the System/370).  Probably the best
(most rigorous) data processing architecture document ever written, and the
source of the Ultimate Truth for many.  See also bible, POO, Princ Ops.
%
POR:  (pore) n. Power-On Reset.  See also plan of record.  The general reset
of a piece or system of hardware that takes place when the equipment is first
switched (powered) on.  Since all hardware requires this, a power-off
followed by power-on can often be used to reset a machine to a known state.
See Big Red Switch, key off/key on, Poughkeepsie reset.
%
PROFS:  (profs) 1.n. Professional Office System.  A menu-based system that
provides support for office personnel [such as White House staff], using IBM
mainframes.  Acclaimed for its diary mechanisms, and accepted as one way to
introduce computers to those who don't know any better.  Not acclaimed for
its flexibility.  PROFS featured in the international news in 1987, and
revealed a subtle class distinction within the ranks of the Republican
Administration in the USA.  It seems that Hall, the secretary interviewed at
length during the Iran-Contra hearings, called certain shredded documents
"PROFS notes" [as do IBMers who use the system].  However, North, MacFarlane,
and other professional staff used the term "PROF notes".  2. v. To send a
piece of electronic mail, using PROFS.  "PROFS me a oneliner on that".  [A
PROFS one-liner has up to one line of content, and from seven to seventeen
lines of boiler plate.] See also VNET.
%
PSE:  (pee-ess-eee) n. Preliminary Sales Estimate.  A qualified guess at how
many units of a product will be sold.  Nobody except a forecaster can explain
why this is different from a forecast.
%
PTF:  n. Program Temporary Fix.  This is an official IBM temporary fix.  The
abbreviation is used so often that most people don't know what it stands for.
PTFs are permanent fixes in some systems, which has led to the false
definition of permanent temporary fix.
%
PTM:  n. Program Trouble Memorandum.  The same as an APAR, but generated
internally, before a program is shipped.  Also known as PTR (Program Trouble
Report); both are sometimes used as verbs.
%
Pagoda:  n. The IBM Centre in Sydney, Australia.  Named after the shape of
the awnings adorning the building.
%
Panda-:  n. A generic name for an object, usually in the form of a prefix.
Usage "That could conflict with PandaCalc".  First used generically in the
construction "Pandamuffins".  See also Finnoga-, Fred.
%
Phase 0:  adj.  Preliminary.  From "Phase 1 review", which is the first
official review of a project.  A "Phase 0 review" is a preliminary review,
often conducted as a trial run for the real Phase 1. Hence, "do a Phase 0
estimate" means "do a preliminary estimate".
%
PizzBoo:  n. The Publishing Systems Business Unit, one of the first to
BiCapitalize mainframe products.  From the usual pronunciation of its
abbreviation, PSBU.
%
Pokieland:  n. The Poughkeepsie area.  The term is mainly used by people
outside Pokieland.  [There is also a cave, in northwest Massachusetts, named
"Pokie Hole" in honour of Poughkeepsie.]
%
Poughkeepsie Confidential:  adj.  Of a document unavailable.  This
classification, though unofficial, is nevertheless the most secure in IBM.  A
Poughkeepsie Confidential document cannot be distributed, even by its author,
without management approval (even if the manager who approves the
distribution is junior to both the sender and the receiver).  See also IBM
Confidential.
%
Poughkeepsie reset:  n. An unpublished feature on all IBM data processing
equipment, this feature is actually a switch connected directly to the main
power source.  A flip of this switch (usually named the "ON/OFF switch") will
reset 99% of all annoying device problems.  However, the trade-off for such a
life-saving capability is the probable loss of some existing data or state
information.  See also POR.
%
Princ Ops:  (prince-ops) n. A verbal abbreviation for the System/360 (and
later extensions) Principles of Operations Manual.  Used by the System
Architecture group in Poughkeepsie, and others.  See also POO, POP.
%
Problem Determination Guide:  n. A small booklet allowing one to determine
that a non-functioning (read broken) 3278 or 3279 terminal is indeed
nonfunctioning.  Unfortunately, it does not give the slightest hint about how
to make it work again.  (There is a Problem Reporting Form, however.)
%
Quality:  n. A once-popular hot button characterised by the slogan "do it
right the first time ". A laudable aim, pounced upon with glee by product
managers who claim that they do their design right, first time, and that
therefore testing with real users is obviously a waste of time.  In an
extraordinary use of English, an official definition of "quality" defines it
as Conformance to Requirements.  [Not in this Dictionary!] A 1987 Quality
poster put it this way "Quality A place for everything, and everything in
it's (sic) place".
%
Quality Circle:  n. A group of people gathered together to celebrate the
cause of Quality, and sometimes to bring forth good ideas for increasing the
sum of product quality.  Said to be the most perfectly formed closed loop of
ideas around which a group can travel continually only to to get nowhere that
they haven't been before.
%
RDR:  (reader) n. An abbreviation for reader.  From the VM standard name for
the virtual card reader.
%
RETAIN:  n. A database and network that contains references to many of the
problems found using IBM equipment and software, together with a solution for
the problem (if known).  This term is an acronym for Remote Technical
Assistance Information Network, but is also used as a verb.  "Let's RETAIN
that one".
%
RFA:  n. Request For Announcement.  The primary, formal, document that is the
core of the announce process and product release.  RFAs for major
announcements may circulate (in various versions) for months before announce,
with hundreds of reviewers on the distribution list.  At any one time there
are thousands of RFAs in circulation.
%
RISC:  n. Raleigh International Systems Center.  (Now the International
Technical Support Center - Raleigh.) See also RISC technology.
%
RISC technology:  (risk technology) n. Reduced Instruction Set Computer
Technology (as used in the IBM RT PC and the RISC System/6000 series).  In
IBM parlance, this means the 32-bit 801 Minicomputer Architecture devised at
the Yorktown Heights location (the T. J. Watson Research Center), building
801.  The prototype for this machine used 24-bit wire-wrapped Emitter Coupled
Logic, and was therefore a surprising triumph over electrical noise; the
integrated circuit version of this architecture is rather more compact, and
rather more reliable.
%
RIT date:  (writ-date) n. The moment of commitment to the design of an
integrated circuit chip.  RIT stands for Release Interface Tape.  This "tape"
is the collection of information necessary to process and test a chip.  It is
no longer moved from place to place on a magnetic tape, but is sent
electronically.
%
ROJ:  (rodge) adj.  Retired On the Job.  A common designation for petty
bureaucrats and others simply marking time.  Some of these can actually tell
an enquirer the number of days they have before their official retirements.
See also IPR, gold-coaster.
%
ROLMan:  (rolm-an) n. An employee of the ROLM company, after it became a
division of IBM and before it was sold to Siemens in 1989.  An alternative
term is ROLMulan.
%
RPQ:  n. Request for Price Quotation (for an infrequently requested feature,
such as upper/lower case, or compatibility with earlier products).  The RPQ
"route" is taken to get an important modification or enhancement to a product
in a shorter time than can be achieved through the formal requirement and
release cycle.
%
RTFM:  v. Read The oFficial Manual.  Used, with variations on the third word,
to suggest to someone that instead of wasting another's time with questions
the manual should be consulted.  [It has been pointed out that RTFM is not
the most expressive term.  The alternate form RTFB (where B is for Book) is
preferred by native speakers of English, since "Manual" is from the French
but "Book" is a suitable and short four-letter English word, which better
fits the slogan.]
%
R I:  n. A Read and Initial memorandum.  A form of memo circulated with the
intention of its being read by an entire department in a timely fashion.  The
progress of circulation is indicated by the initials of the readers (and
sometimes the date when it is read).  Generally completes the cycle 2 to 4
months later, if at all, and is therefore an extremely useful way of delaying
a decision on a document more or less indefinitely.
%
Registered IBM Confidential:  adj.  The highest level of confidential
information.  Printed copies are numbered, and a record is kept of everyone
who sees the document.  This level of information may not usually be held on
computer systems, which makes preparation of such documents a little tricky.
It is said that RIC designates information which is a) technically useless,
but whose perceived value increases with the level of management observing
it; or b) is useful, but which is now inaccessible because everyone is afraid
to have custody of the documents.  See also candy-striped.
%
Rexxpert:  n. An expert in the REXX language.  A Rexxpert of long standing is
known as a Rexpert, for historical reasons.
%
Rusty Bucket:  n. A group headquarters in Bethesda, Maryland; often shortened
to simply Bucket.  The outer skin of the building is an alloy designed to
react with water and standard metropolitan pollutants to "rust pretty" on the
surface.  Lacking the requisite pollutants, the building just plain rusted.
Its distinctive qualities make it one of the places in the Washington (DC),
area for which [it's said] no address is required.  You can tell a cab driver
that you want to go to the Rusty Bucket and you'll get there.  You can mail a
letter to the Rusty Bucket, Bethesda, MD and it'll get there.
%
SAA:  (ess-ay-ay) n. Systems Application Architecture.  A collection of
interfaces (to users, for programmers, and for communicating with other
computers) that most of IBM's major product lines are committed to support.
To be SAA is to be strategic.  "Is it SAA?"
%
SCIDS:  (skids) n. A 6-hour social occasion, held every night of SHARE and
GUIDE meetings, during which customers (sometimes successfully) ply IBMers
with alcoholic beverages in plastic cups to try to find out what's coming
next.  Originally informally known as "Share Committee for Inebriates,
Drunkards, and Sots", but now officially stands for "Social Contact and
Informal Discussion Sessions" or "SHARE Committee for Informal Discussion
Sessions".  More familiarly known as the "Society for Cultivation of
Indiscretions via Drinking Sessions".
%
SMOP:  (smop) n. Something quite possible, but requiring unavailable
resources to achieve.  "Why isn't that function available in the program?" -
"It's just a Simple Matter Of Programming".  (The implication being that,
given a few person-centuries, all things are possible.) Also SMOUP (smoop), a
Simple Matter Of MicroProgramming (if hand-written, using a Greek mu).  See
also how hard would it be.
%
SP:  n. System Product, as in Virtual Machine/System Product (VM/SP).
Although there are many different System Products, only VM is known as "SP".
As in "Are you running SP?"
%
SVC13:  v. To create a dump; to create waste.  From the identifier of an OS
supervisor call (SVC) instruction.  SVCs are used to communicate between user
address spaces and the system supervisor, including hardware facilities.
Each SVC function (load, attach task, etc.) has a specific identifier, 13
being used to terminate a failing address space with a dump.  See also brain
dump.
%
SYNTAX ERROR:  1.n. An unidentified error.  A general message put out by
compilers and interpreters when a) the error was never expected to occur; or
b) the programmer got tired of dreaming up new error messages for trivial
cases; or c) the compiler failed, but it was easy to blame the error on the
user.  2.n. An expletive used to cover a speaker's embarrassment after making
a gaffe.  "Oops!  Syntax error!"
%
Salt Mine:  n. Hutchinson, Kansas, where many vital records are sent.  There
are stories of huge underground caverns, whence was mined rock-salt, filled
with salty tapes and documents.  See also Iron Mountain, Wansdyke.
%
Sammy Cobol:  n. See Susie Cobol.
%
Scientific Centre:  n. A research (not Research) laboratory dedicated to
performing computing research of interest to people outside IBM.  Projects
are justified on their relevance to the non-IBM wider technical community.
%
Seven Dwarves:  n. A term describing the most significant companies in data
processing in the USA in the 1960s - other than IBM.  Originally the
expression "IBM and the Seven Dwarves" described the entire computer
industry.  The Dwarves were Burroughs, Honeywell, NCR, Univac, RCA, General
Electric, and the new upstart, CDC.  Since then RCA and GE have dropped out,
while Burroughs and (Sperry)-Univac have merged to form Unisys, so now there
are four.  Some consider DEC to have become sufficiently respectable to
constitute a fifth, and Microsoft's chairman has sufficient renown for his
company to be considered a sixth, but no present-day seventh comes to mind.
Dwarves are at least in principle exempt from the definitions of minicomputer
and vector processor since they are deemed to produce "ordinary" computers
like IBM.  Of course, the term should really be "Seven Dwarflings"?  See also
Bunch.
%
SneakerNet:  n. A high-bandwidth file transfer procedure between PCs that are
not connected electronically.  Usually implemented with a bunch of floppies
and a good pair of sneakers [soft shoes, worn in the USA].  Also called
CarpetNet.  See also TapeNet.
%
Snow White:  n. IBM.  See Seven Dwarves.
%
Speak Up!:  n. An exemplary personnel programme which allows employees to
make a genuinely anonymous complaint to any level of management about any
IBM-related subject.  Replies to Speak Up!s range from a (quite common)
positive acceptance of the complaint and resultant change, to a (more common)
patronising brush-off which may aggravate the original feeling of
dissatisfaction.  The programme does, however, provide a mechanism whereby
employees can get the autograph of senior members of the Corporation on
personal letters to them [except in IBM Israel, where the replies to Speak
Up!s are not signed].  See also open door.
%
Spring Plan:  n. A plan, adopted in the spring of each year, that describes
the long-term activities and business of a location or division.  [Now known
as the Strategic Plan.] See Fall Plan.
%
Sunny and Warm Division:  n. The South-West Marketing Division.  (Alternative
expansion of the abbreviation - a geographical truism.) See also Nasty and
Cold Division.
%
Susie Cobol:  n. A programmer straight out of training school who knows
everything - except the benefits of comments in (plain) English.  Also
(fashionable among personkind these days to avoid accusations of being
sexist) Sammy Cobol.
%
T3:  n. Teach The Teachers time.  The beginning of the spreading of the
marketing information for a product which typically occurs about a week
before a product's announcement.
%
TAT:  (tat) v. To test the Turn-Around Time of a conferencing facility.  This
is done by sending an append to a test forum (usually called TESTER) on the
master and seeing when it is echoed back to the local shadow.  This can help
one determine whether shadow inactivity is due to an idle master or to a
broken network link.
%
THINK:  (ponder) 1. v. Think.  Perhaps the most famous IBM slogan.  This was
originally used by the first Mr.  Watson, around 1900, to convey the idea of
complete staff work.  That is, given a problem or a challenge, time should be
taken to reason the problem through and cover all involved aspects carefully,
and to consider all repercussions and (of course) all financial
considerations.  This is not unlike the more recent "Make Sure" and do it
right the first time slogans now used within the Quality Program.  "Think" is
also the name of the in-house magazine distributed to all IBM employees in
the USA (but considered too syrupy for the more cosmopolitan tastes in the
other half of IBM).  2.n. (Meaning unknown.) A well-established IBM acronym
which is so wellestablished that no one can remember what it originally
meant.  Said to exemplify an ideal that cannot be achieved.
%
TIE system:  n. Technical Information Exchange system.  A computerised
Bulletin Board system, as might be operated by a PC Club.  Since the essence
of such a system is the public exchange of information by the subscribers,
and since posting information on (or to) anything called a "bulletin board"
is a management prerogative, a different name had to be found.
%
TIME/LIFE:  n. The legendary (defunct since 1975) New York Programming
Center, formerly in the TIME LIFE Building on 6th Avenue, near the
Rockefeller Center, in New York City.  For many years it was the home of
System/360 and System/370 Languages, Sorts and Utilities.  Its programmers
are now primarily in Kingston, Palo Alto, and Santa Teresa (or retired).
%
TLA:  n. Three Letter Abbreviation.  A four-letter abbreviation is, of
course, an XTLA (eXtended Three Letter Abbreviation).  See also acronym.
%
TNL:  1.n. Technical Newsletter.  Replacement pages containing miscellaneous
technical changes to an existing IBM manual, often published between editions
or releases.  Considered to be synonymous with the phrase, "We forgot to tell
you about this," or "This is how it really works".  The TNL's binding, size,
and three-ring binder holes must be just slightly different from those of the
base manual.  2. v. To publish or issue a technical newsletter.  As in "We
can always TNL it later".  See also fix it in pubs.  -to suffix.  Used to
make an ungrammatical sentence slightly more or less grammatical, according
to the whim of the user.  This can be used with almost any verb, as in "We
can't exit Phase 0 without an agreed-to IBP".
%
TOOLS disk:  n. A disk of shared data (especially of programs or computer
conferences) that is maintained automatically by the TOOLS and TOOLSRUN
programs.  TOOLS was created in 1981, and now maintains tens of thousands of
disks of data in IBM, mostly shared and copied across VNET.
%
Tandem Memos:  n. Something constructive but hard to control; a fresh of
breath air (sic).  "That's another Tandem Memos".  A phrase to worry middle
management.  It refers to the computer-based conference (widely distributed
in 1981) in which many technical personnel expressed dissatisfaction with the
tools available to them at that time, and also constructively criticised the
way products were [are] developed.  The memos are required reading for anyone
with a serious interest in quality products.
%
TapeNet:  n. A very high-bandwidth file transfer procedure between mainframes
that are not connected electronically (e.g., because of a network failure).
Files are written to tape, taken by courier to the destination system, then
re-loaded there.  See also SneakerNet.
%
TechRef:  n. The IBM PC Technical Reference Manual (TRM).  The TechRef is the
only PC documentation that will be read by self-proclaimed "real" PC
programmers.
%
The Company:  n. IBM.
%
Tower C, Tour C:  n. The cafe/bar opposite the entrances of Towers A and B of
the European Headquarters in Paris.  Usage "Confidential matters will not be
discussed at Tower C".  It is reported that, when it first opened, Tower C
did very poor business in the early evening until curtains were installed so
that homewardbound executives couldn't see who was inside.
%
Trouble Came Back, TCB:  n. A problem that has failed to succumb to its
solution.  This colloquialism is used by maintenance people to describe an
intermittent or difficult-to-reproduce problem which has failed to respond to
neglect.  See no problem found, go away.
%
Tuesday:  n. The Day of the Announcement.  For various reasons, most (if not
all) IBM Domestic products are announced on a Tuesday.  [It is said that this
originally came to pass because T. J. Watson went sailing at weekends, and
could not be sure of returning on a Monday if winds should fail him.] The
major exception to this rule occurs when April Fool's Day is a Tuesday (as in
1986), in which case announcements are delayed until the Wednesday - 2nd
April.
%
Tyranosaure:  n. REXX, when used in France.
%
UKUS:  (yuke-us, you-kay-you-ess) adj.  Of syntax, pronunciation,
punctuation, or spelling differing between UK and US (British and American)
English.  Usage "That flavour of `flavor' is ukus".
%
UP-genned:  (you-pee-genned) adj.  Of a system generated to use only one
processor of a multi-processor hardware complex.  Often a "trick" that
simplifies the work of the sysprog, who then hopes that no one notices that
the system is not running as fast as it might do.  [Usually applied to avoid
software that simply does not work on multi-processors.] Also used to
describe a person who can only deal with a single problem at a time.
%
VM:  n. Virtual Machine.  Used universally within IBM to refer to the VM/370
Operating System, now known as VM/SP (Virtual Machine System Product).  VM is
the most general IBM operating system for the System/370, since it alone
allows all the other operating systems to be run under it (including itself).
It is the operating system of choice within IBM for almost all development
work, since its single-user Conversational Monitor System (CMS) is faster and
more adaptable than the alternatives.  See also SP.
%
VMITE:  (vee-might) n. VM Internal Technical Exchange.  A gathering of many
of the IBM VM System Programmers, held for ten years in or near San Jose.
With the steadily increasing number of VM systems, this meeting maintained
its vitality in a way unusual for this kind of regular conference from its
first meeting in 1978 until it was superseded by the CCITE in 1989.  The
meeting was originally organized and hosted by Ray Holland, then of the
General Products Division VM System Support group at the Santa Teresa Lab.
It was first held at the San Jose Research Laboratory, then later at the San
Jose Convention Center, and finally at the Almaden Research Center.
%
VMNews:  (vee-em-news) v. To submit an item to the VM Newsletter.  The VM
Newsletter, edited by Peter Capek, ran for 50 editions in the late 1970s and
early 1980s and was certainly the most useful communication newsletter within
IBM, its usefulness only later being eclipsed by the growth of conferencing
systems.  Therefore to VMNews a piece of information is to ensure its wide
distribution.  A different meaning sometimes occurs to the select group of
enthusiasts who submitted items to the 51st edition.
%
VMR:  v. To reject.  From Very Much Regret, the wording used in the standard
rejection letter for PC Software Submissions "I think we should VMR this
one".
%
VMSHARE:  n. A conferencing system used by the VM project of the SHARE
organisation (a user's group of IBM customers).  A copy of the conference is
provided by SHARE for IBM use; there is also a later PCSHARE conference.
%
VNET:  (vee-net) v. To send by computer network (as opposed to tape or mail).
"I'll VNET you the files tomorrow".  The verb derives from the name of the
original IBM communication network set up within IBM during the 1970s, and
now linking over 2600 computers.  The V, incidentally, means nothing - the
name was chosen to resemble the other familiar acronyms of the time (VSAM,
VTAM, and so on).  VNET is sometimes described as "a communication network
for Service Machines, which humans are sometimes able to use".  See also net.
%
Vector Feature, Vector Facility:  n. An optional vector processor that can be
added to an IBM 3090 mainframe.  The Vector Feature, developed at the
Poughkeepsie Laboratory, is remarkable for being a major hardware product
that was developed entirely "on the sly" - so much so that it's said that not
even IBM's competitors knew about it.  See hobby.
%
WIBNI:  (wib-knee) n. Acronym for "Wouldn't It Be Nice If", usually used to
refer to useful but difficult-toimplement additions to software systems.  "I
have a WIBNI for the zorch function".
%
WYSIWYG:  (wizzy-wig) 1. adj.  What You See Is What You Get.  Applied to a
text, graphics, or image editor that tries to show on the screen exactly what
will appear on the printed page.  WYSIWYG technology is rather crude at
present, prompting the comment "What You See Is All You Get", but it seems
that this kind of display is appropriate for certain applications.  [This
term was first used in IBM by the 5520 and text architecture designers, in
1977-78.] Also WYSLN (wizz-lin) - What You See Looks Natural.  2. adj.  Of a
display panel having no help.  "All of our interactive functions have been
rewritten using WYSIWYG panels".  See also user-friendly.
%
Wansdyke:  n. Mysterious caverns in England, "somewhere" near the ancient
Saxon earthwork known as Wansdyke, where vital records are stored.  UK
equivalent of Iron Mountain, Salt Mine.
%
Watson Freeway:  n. The sections of Interstates 684 and 287 which connect
Corporate HQ (Armonk) with NCD HQ (1133, see below) via Harrison.
%
Watson's Law:  n. The reliability of machinery is inversely proportional to
the number and significance of any persons watching it.  (This well-known
rule applies to all demonstrations of new equipment, software, etc.)
%
Winchester disk:  n. A hard (rather than floppy) disk whose head rests upon
the surface of the disk when stationary.  The name "Winchester" was first
used as the code name for a disk storage device being developed at the IBM
San Jose engineering laboratories around 1973, and has since become the
industry generic term for that disk technology.  The rationale for the name
was the original size of the twin storage modules, which were 30 Megabytes
each, matching by analogy (30+30) the cartridge used in a Winchester 30-30
rifle.  (In this case the first 30 refers to the calibre of the rifle, and
the second to the grains [weight] of powder used in the cartridge).  The
Winchester was the first device whose read/write head could actually rest
upon the surface of the disk without disastrous consequences.  The head
assembly mass was reduced from 300 grams for the 3330 disk to a feathery 18
grams, thus successfully fulfilling the original aim of eliminating the
costly headunloading mechanism.  The direct cost of the head dropped by a
factor of four as a consequence of this.  The capacity of the disk that was
actually released as the 3340 later grew to 35 and 70M, but the name stuck.
The name became public during a court case that debated an attempt to
misappropriate the technology.  The term "Winchester" was a convenient handle
for describing the intellectual property, and came up regularly in the court
and in the reports of journalists covering the trial.
%
XA:  n. Extended Architecture.  The extension of the System/370 architecture
from 24-bit addressing (allowing access to 16 Megabytes of storage) to 31-bit
addressing (allowing access to 128 times as much).
%
Yorkthorne:  n. The Hawthorne extension of the T. J. Watson Research
Laboratory at Yorktown Heights, NY.
%
Yorktownism:  n. An incantation that works only on the Yorktown version of a
standard operating system.  Yorktown is infamous for running the most
adulterated VM systems in the company - as many toolsmiths there have
discovered when they tried to let others use their work.
%
Z-Block:  (zed-block) n. The first temporary building in Hursley, there
before IBM moved in, which was used by Supermarine for Spitfire (a World War
II fighter aircraft) design.  The legendary birthplace of the Hursley
Programming Centre.  Now describes the 2nd floor West Wing of D-Block, home
of the new CICS design technology (which uses Z-notation).
%
accept:  n. A purchased and (usually) installed product, most often used in
the plural.  As in "The demand number is the marketing estimate of customer
accepts..."
%
account situation:  n. Circumstances at a customer installation which could
lead to IBM losing revenue or reputation.  A "red alert" state for a branch
office.  See also critical situation.
%
acronym:  n. A word formed from the (or some) initial letters of other words
and often printed in uppercase.  Strictly speaking, if it can only be
pronounced letter-byletter then it is merely an abbreviation.  An example of
an acronym "Acronyms A Convenient Reduction Of Nomenclature Yielding Mnemonic
Syllables".  Acronym is, in itself, not an IBM word, but acronyms are a way
of life in the computer business; there are so many acronyms and
abbreviations in use in IBM, and so many are coined each day, that this
dictionary cannot attempt to list them.  It must suffice to record the
discovery of one of a number of three-level acronyms GOCB.  In this acronym,
the O stands for OSD, in which the O stands for OSI.  The G stands for GTMOSI
(a mere two levels), and so the full expansion of GOCB is "General
Teleprocessing Monitor for Open Systems Interconnection Open Systems
Interconnection Session Driver Control Block".  See also TLA.
%
action:  1. v. To do something, or (more commonly) to delegate to someone
something that needs to be done.  "We must action finishing off the
documentation".  2.n. An action, agreed at a meeting, that a particular
person is expected to take.  "I have an action to organize this year's family
dinner".
%
action item:  n. An action recorded in the minutes of a meeting, or brought
forward to the agenda of the next meeting.
%
action plan:  n. A plan.  Project management is never satisfied by just a
plan.  The only acceptable plans are action plans.  Also used to mean an ad
hoc short-term scheme for resolving a specific and well defined problem.
%
added value:  1.n. The features or bells and whistles that distinguish one
product from another.  As in "This mission is strategic to our division.  If
we are to keep it, our proposals must have visible added value".  2.n. The
additional peripherals, software, support, installation, etc., provided by a
dealer, such as an IBM VAR (Value Added Reseller) or VAD (Value Added
Dealer).
%
adder:  n. An increment.  "These costs won't look so attractive with the
burden and inflation adders".  Nominated for most obnoxious neologism of
1980.  The word uplift is now a common and equally obnoxious alternative.
%
address:  v. To talk about.  Used when a speaker cannot answer a question, as
in "I shall address that subject another time" (this implies that, of course,
the speaker has considered the subject in great depth, but sadly has not
enough time now to give it the treatment it deserves).  See offline.
%
adjective:  v. To use a word as an adjective modifying some other word which
in fact modifies the adjectived word.  This avoids the normal use of
prepositions and dependent clauses, as in "user effects" (instead of "effects
on users" or "effects caused by users").  Another example is "That is a
documentation hit" (rather than "That is a hit on the documentation").  See
also verb.
%
administrivia:  n. Any kind of bureaucratic red tape or paperwork, IBM or
not, that hinders accomplishment of one's objectives or goals.  Often,
anything with a routing slip attached.
%
adtech:  n. Advanced Technology.  Time put aside for a risky project, not
necessarily directly related to a product.  May mean a) Play time (when
someone else is doing it), or b) Exciting, innovative system design with no
product deadlines (when speaker is doing it).
%
aeroplane rule, airplane rule:  1.n. "When you are lost, climb and confess".
2.n. Complexity increases the possibility of failure; a twin-engine aeroplane
is more expensive and has twice as many engine problems as a single engine
aeroplane.  When applied to large computing systems, the analogy is that two
power supplies (even though running at overrated current output) driving two
boards of logic are much more reliable than four power supplies of correct
value with each pair driving each of two logic boards.  When reliability is
the stronger consideration a different design will result than when
availability (with concurrent maintenance) is the major criterion.  See fence
out.
%
aggressive:  1. adj.  Optimistic, vigorous, very active.  In IBM, implies an
element of risk "We are moving into the new technology on a very aggressive
schedule".  2. adj.  Over-ambitious.  As used on a foil "1988 plan was very
aggressive", which actually meant "we did not make target" and "the
forecasters got it wrong again".
%
air movement device:  n. A mechanical rotating component with angled blades,
used in the IBM PC family and in the 4341 processor for cooling purposes.
When used in the (now defunct) IBM Copiers, it was known as an air cooling
device.  [Even earlier, it was known as a "fan"; the term has been
abbreviated for convenience.]
%
alarm:  v. To fit with an alarm device.  Observed on doors in San Jose and
elsewhere "This door is alarmed".  [Soothe, soothe...]
%
all-blue:  adj.  Of a customer having purchased all major computing equipment
from IBM.  "An all-blue account".  See also true blue.
%
all cycles to list:  expression.  Nothing new.  Old-timer's response to "How
are you"?  This was the standard "just list" invocation, wired on an
accounting machine panel.  See also CI to C.
%
all-elbows:  adj.  Of a resident PC program unsociable.  Used to describe a
program that bluntly steals the resources that it needs without regard to
others.
%
all hands meeting:  n. A meeting, called by upper management, which everyone
working on a given project is required to attend.  Probably from the nautical
"All hands on deck!" Since most of these meetings are called to announce
changes in the management tree, there is some evidence that the intended
reference is to shuffling the deck.
%
alphameric:  n. Alpha-Numeric.  Used to describe those characters that are
either alphabetic or numeric.  The alphamerics are often restricted to a
single case of alphabetic, and rarely include any non-English alphabetics.
%
:  (ampersand) 1.n. A character used in many IBM macro and command languages
in order to distinguish data from keywords.  This helps to make them hard to
read and to type, and so adds to the mystique surrounding programmers that
use such languages.  Sometimes used doubled, for double confusion.  See
command language.  2. adj.  Fluid in name.  When the name of a project or
future product is (or is likely to be) changed many times, the authors of its
documentation will often use a variable symbol to represent the name that is
likely to be changed.  In the standard IBM documentation language, SCRIPT,
such symbols are identified by a leading ampersand.  This usage carries
forward into speech, where one speaks of the "ampersand xyz" project, where
"xyz" is the current name.  See also symbol.
%
angel dust:  n. Another name for green lightning.  Refers to the slang name
for a drug [phencyclidine] that is said to result in hallucinations and
psychotropic effects similar to the flashing streaks known as Green
Lightning.
%
announce:  n. The time at which a new product is described to customers.
Before this time a product is known by a code name, and specifications are
strictly confidential.  At announce, the product is assigned a number instead
of a name, with the result that not even the developers know what it is any
more.  See also ESP, FCS, GA.
%
append:  n. A piece of text (ranging from one line to several hundred) that
is appended to a file on a conference disk.  The text may be discussions, bug
reports, suggestions, questions, or any other topic of conversation.  The
value of an append is very often inversely proportional to its length.  See
also conferencing facility, forum.
%
application tower:  n. A series of programs that have been grouped together
to form a package which can be used conveniently for a particular
application.  The package is built on a common base that is shared by several
application towers.  See tower.
%
architect:  1. v. To design how something should work.  Usage "We will have
that architected by year end".  2. v. To document, ex post facto, the way a
particular piece of hardware [and sometimes software] works.
%
architectural awareness:  n. An improvement to a building.  Site Facilities'
version of Feature.  A popular variety is a column placed directly in front
of a door, claimed to be deliberate.  Warning At the Glendale Laboratory
(Endicott), and at the Greenford Distribution Centre (London), you will be
offered attractive bets that this has never happened.  Do not accept!
%
architecture:  1.n. The way something works.  Usage "They are developing a
new disk architecture".  2. adj.  Documentation.  Usually in the form
"architecture group" that denotes a group of people who go around finding out
how the most highly esteemed IBM products or planned products work and then
document them.  These documents then become the IBM "standard architecture"
or "strategic architecture" which the rest of the (IBM) world then has to
follow.  Note You cannot spell "Architecture" without "hit".
%
archive:  v. To save data (usually electronic) in long-term storage (such as
magnetic tape or optical disk).  This differs from backup in that it is
intended that the data be kept for a long time, perhaps indefinitely.  Data
are archived when no longer in constant use, and the space taken up by the
data is needed for other purposes.
%
arm waving:  n. A technique used to convey excited dedication to an idea,
even though not supported by arguments or facts.  "The pitch had much arm
waving but little content".  The technique may be attempting to emulate the
effect of waving one's arms (as if trying to fly) near a flock of seagulls
[or wild ducks?] who will then all take off together.
%
artificial intelligence:  1.n. The opposite of natural silliness.  2.n. A
research topic in Computer Science.  Some in the computer industry seem to
think that nothing useful can come out of artificial intelligence (but they
don't trust the natural kind, either).
%
assembler:  1.n. A program that takes the symbolic language used for writing
machine level (binary) instructions and converts that language into the
machine level instructions.  2.n. A symbolic language for writing machine
level (binary) instructions.  Also assembly language.  Usage "You mean the
whole interpreter is written in assembler?" The original assembler language
for the System/360 series was known as BAL (Basic Assembler Language), as in
the title for GC26-3602-7 (October 1972) IBM System/360 Model 20, Card
Programming Support, Basic Assembler Language.  See also code, microcode.
%
assemblerize:  v. To rewrite in assembler for better performance.  Curiously,
verbs such as "Cobolize" have not appeared, perhaps because they would seldom
be used.
%
assist:  n. A modification to the microcode of a processor (or to a system
control program) to improve the performance of an operating system running
under that microcode or control program.  Usage "YMS runs nearly twice as
fast with the EM assist enabled".  There is a side-effect in using an assist
the number of MIPS measured as instruction decodes often drops substantially,
even though the effective work accomplished goes up.
%
*:  (asterisk) n. A character used (among other things) to denote emphasis.
Most softcopy text (such as electronic mail and forums) is in a single font;
to indicate emphasis without the blatancy of Great Runes, text can be
enclosed in asterisks.  Usage "Do you *really* want the PURGE RDR default to
be SYSTEM ALL?" Since emphasised words are often set in italics, the asterisk
is also used to mark items normally presented in italics, such as book
titles.  See also splat, star out.
%
at this moment in time:  adv.  Now.  Also at this point in time, and the more
pointed at your convenience (now, when pronounced by a manager).
%
attrit:  (a-trit) v. To remove personnel from a department, usually by
finding new positions for the people, and usually because the department's
mission has ended.  As in "I had to attrit my entire department when they
canceled the project".  See also attrition.
%
attrition:  n. The loss of personnel through resignation from the company.
Usage "Attrition this year is 1.7%".  This word is normally used to mean loss
through friction or wearing down; one wonders what (or which) agency is
causing the friction.  The term is also used in this way by Experimental
Psychologists.  See also attrit.
%
auto-pixelization:  n. A method of automatically deriving a dot (raster)
image from the vector outline of a shape (often a character from a font).
%
autoline:  n. An automatic manufacturing line for building components of a
computer system, often wellendowed with robots.
%
automagically:  adv.  Automatically, and so cleverly [or obscurely] that it
seems like some magic must have been involved.  As in "I have an Exec that
does that automagically".
%
award:  n. A monetary bonus given in recognition of a special achievement.
In Research, a cash prize often given to signify the end of a project.
Elsewhere, a cash prize placed sometimes for political effect, but often
associated with (though not proportional to) merit.  See also dinner for two.
%
back-burner:  v. To move something to a lower priority in the hope that it
will go away or be solved by someone else.  "Let's back-burner this item".
[Not originally an IBM term.]
%
back-level:  adj.  Not current.  Describes a program or system that has not
been modified with the latest changes and enhancements.  "Your system is
back-level, so there is no way you can run this new super-program!" See also
down-level.
%
back-page:  v. To communicate a comment on a manual using the Reader's
Comment Form (which is on the back or last page of the book).  A way to get a
change to a manual when direct approach to the author or developer fails.  "I
think we'll have to back-page that item".
%
back-to-back remote:  n. A method for connecting two computers which have
been set up so they can communicate with each other only over a long-distance
line, using 3705s, modems, adapters, etc.  If in fact the two machines are
sitting in the same room, then the line terminals of the two machines can
simply be connected by short wires.  Often useful in initial testing.
%
backbone:  n. The central nodes of an electronic communication network.  The
backbone of IBM's VNET network is managed directly by a corporate
organisation, and in the mid 1980s ran a much-enhanced version of the RSCS
product, known as IPORSCS.  The nodes of the backbone, for example HURBB, are
identified by three characters of the location name, followed by BB (for
BackBone).  At a time of a major software upgrade numerous problems occurred,
which led to the suggestion that in fact the BB stands for bit-bucket.
%
backslash:  n. A backwards sloping slash (i.e., a solidus that slopes from
top left down to bottom right).  This character has suddenly become
overloaded, as it has appeared relatively recently on most IBM keyboards but
used to be unavailable; every new application therefore uses it as an
"escape" character.
%
backup:  1. v. To make a copy of data in a separate place in case of
inadvertent loss of the primary (working) copy.  Often a tedious and
time-consuming process, and so commonly done less frequently and thoroughly
than would be ideal.  2. adj.  Secondary, reserve.  As in "What's the backup
plan?" See also archive, Iron Mountain.
%
bad information:  1.n. Lies.  2.n. The truth, expressed euphemistically.
There is a story (abbreviated here) that well illustrates this Programmer to
manager, "This is manure".  Manager to second-level, "This is fertiliser".
Second-level to third-level, "This makes things grow".  Third-level to
Director, "Must be good stuff".  After an external audit, the misinformed
protect themselves by saying "My people gave me bad information".  See also
CYA.
%
bad response:  n. A delay in the response time to a trivial request of a
computer that is longer than two tenths of one second.  In the 1970s, IBM
3277 display terminals attached to quite small System/360 machines could
service up to 19 interruptions every second from a user [I measured it
myself].  Today, this kind of response time is considered "impossible" or
"unachievable", even though work by Doherty, Thadhani, and others has shown
that human productivity and satisfaction are almost linearly inversely
proportional to computer response time.  It is hoped (but not expected) that
the definition of "Bad Response" will drop below one tenth of a second by
1990.
%
badge:  1.n. A small rectangular piece of plastic (showing the holder's name
and photograph) that purports to prove the identity of the bearer.
Identification badges are almost always required to gain access to IBM
buildings.  In addition, at most large locations they must be worn at all
times.  This wearing of badges is of doubtful value, however, as at least one
study has shown that normal suspicion of a stranger is inhibited if a person
sees an official-looking badge prominently displayed.  2. v. To use a badge
to unlock a door.  A task made harder than it need be, since most
badgeholders are designed for display rather than for use.  Usage "Each
employee must badge in and badge out".  3. v. To mark with a badge.  The main
IBM computer center in Palo Alto has (or had) a large sign at the main
entrance reading "Badged Employees Only".
%
badge run:  n. A walk among all of the areas (such as machine test
laboratories) where one's badge has been authorised to allow entry, inserting
the badge, opening the door (and maybe peeking in), and then leaving to go to
the next area.  The purpose of this is to leave a usage trail to stop
automatic systems removing your badge from the authorised entry list simply
because you haven't used your access privileges enough.
%
ballpark:  v. To make a rough estimate.  Derived from a baseball term.  Usage
"If you don't have the number, can you ballpark it for me?"
%
banana:  1.n. A parenthesis.  A term used especially when dictating computer
language, as in "list fred splat splat left-banana label" for "LIST FRED * *
(LABEL".  2.n. One unit of skill in repairing equipment.  IBM's avowed goal
is to design machines whose maintenance is so simple that the repair
engineers can be replaced by trained monkeys.  Hence, the lowest three levels
of field repairs are sometimes jokingly called One-, Two-, or Three-Banana
tasks.  This concept was used by the RAS group for the 3850 Mass Storage
System at Boulder in the mid 1970s.  At this time there were only one-and
two-banana tasks.  The idea was developed in the 308X RAS and SPR shops, and
was extended to three-banana tasks.  [Such is the march of inflation.]
%
banana curve, planning banana:  1.n. The basis of a forecasting technique
popular in the 1970s.  The method using as much historical data as can be
found, estimated, or invented, calculate for each month the best-ever
year-to-date attainment as a percentage of the year-end total for that year.
Similarly, compute the worst-ever result (which probably happened in a
different year).  Plotting the results by month produces two curves which
both start at 0% and end at 100% but usually diverge in between.  Because
attainment tends to accelerate towards yearend, the region between the curves
resembles a banana.  In use, then, the current year's attainment was plotted,
and if the plot began to fall outside the banana, [an early example of
"pushing the outside of the envelope"] it would be assumed that some person,
product, or event was not performing as he, she, or it should.  2.n. A
plan-by-time graph that shows exponential growth, because of the end-of-year
panic by sales people with unfulfilled quotas.  "Well folks, we just made it
last year, but this time we must straighten the banana curve".  [This usage
probably derives from misunderstanding the earlier usage.]
%
banana label:  n. The curved label stuck to magnetic tape reels and intended
to identify the contents.  It usually contains only a large number and some
arbitrary audit information.
%
banana problem:  n. Not knowing when to stop.  This derives from the story
about the child who said "I know how to spell `banana', but I don't know when
to stop".  Used, for example, when trying to decide how far to refine a
design.
%
banner:  n. Several lines of boiler plate at the beginning of a file (such as
a forum) indicating its security classification.  Usually sufficiently large
that it obscures the useful information normally placed at the start of a
file - especially irritating when trying to browse such a file when connected
via a slow communication line.  On PC software, the banner takes the form of
the display of a giant logo and copyright notice, which usually cannot be
bypassed.
%
bathtub curve:  n. A curve, very much the shape of a Victorian bathtub, that
characterises the failure rates of components with time initially high,
dropping to a very low level, then rising again at the end of the component's
life.  See also burn-in.
%
baud:  n. The speed of a communications line, expressed in "raw" state
changes per second (not necessarily binary).  [Not an IBM term, but included
here as it is often thought, by IBMers and others, to describe the actual
data rate achievable - which can be wildly optimistic (as it includes any
protocol bits, error checking bits, etc.) or pessimistic (as some schemes can
encode more than one bit in a state change).]
%
bean counter:  1.n. A person whose job is to find flaws in reports dealing
with financial matters.  According to popular lore, if no mistakes are
detected then this person has the job of changing accounting procedures in
order to generate some mistakes.  2.n. An individual who refuses to accept
any proposal to improve a product (or the work environment) unless it can be
quantitatively equated to a monetary reduction in corporate expenditures, or
a short-term increase in corporate revenues.  3. n. A person who insists that
an employee be at his desk by 08 30 precisely.  (Even though this means that
he must rise an hour earlier in order to catch an earlier train than the one
that would get him to his desk at 08 33.) bed.  See get in bed with.
%
bells and whistles:  n. Frills added to a program or product to make it more
exciting without making it much better.
%
belly up:  adj.  Broken, not functioning (as for dead fish).  Used to refer
to a piece of hardware that was functioning, but has ceased to do so.  (This
adjective is most commonly heard at the most critical point of the final test
cycle.) Often used in the form "To go belly up".  See also casters up mode,
down.
%
best-of-breed:  adj.  Comparable to recently announced competitive products.
This term is used by planners and enthusiasts, when a product is first
proposed, to describe the relationship of a product to its competition.  Not
used in later phases because (by then) the competition has improved and at
the same time many of the nicer features of the new product have been removed
due to schedule pressures.
%
bet your job:  v. To take a risk.  On the rare occasions that major risks are
taken, the responsible manager or consultant will make capital of such
derring-do "I'm betting my job on this".
%
beta test:  v. To test a pre-release [potentially unreliable] version of a
piece of software by making it available to selected customers and users.
This term derives from the early (1960s) IBM product cycle checkpoints, now
replaced by inspections and explicit test phases.  "Alpha Test" corresponds
to today's Unit or Component Tests; "Beta Test" was the Ship Test (system
test).  These "greek letter" assignments were in turn derived from the
earlier A, B, and C tests for hardware.  The A-test was a check that the idea
for the product was feasible and that the technology was available and could
be manufactured.  Once passed, the product could proceed to design and
development.  The B-test was the most significant checkpoint it showed that
the engineering model (often just an advanced prototype) could run and
perform as specified.  The C-test was a repeat of the B-test on the first few
production machines.  The term "Beta Test" is now widely used throughout the
computer software industry.
%
bible:  n. A master reference document (for example, the System/370
Principles of Operation).  "I don't believe that Divide sets the condition
code - I'll check it in the Bible".
%
big iron:  n. Large computers.  Also big iron bigot.  See iron.
%
bigot:  n. A person with a passionate or religious (superstitious) fervour
for a language or system.  As in APL bigot, "REXX bigot", "CMS bigot".
Implies an unwillingness to learn any alternative, except when the term is
used by one bigot to another (of the same type), in which case the
implication is almost affectionate.
%
binary aboriginal:  n. Someone who programmed computers before 1975.  A term
of endearment, usually identifying a programmer who a) Codes only in
assembler or even without one; b) Knows the original reason why DISK DUMPed
files have sequence numbers; c) Dated or was dated by keypunch operators; d)
Knows what a core dump is; e) Graduated from college with Mathematics or
Electronics (Computer Science did not exist then).
%
binary data:  n. Non-textual data (data that include characters other than
those normally recognisable when printed).  All data in a computer are stored
in binary form, but some are more binary than others.
%
bit:  n. A single binary digit, which can have one of two values,
conventionally described as "0" or "1".  A contraction of "Binary Digit".
Most computers use, at the fundamental electronic level, a binary
representation of data.
%
bit-bucket:  1.n. A notional bottomless hole into which vital messages and
files fall when some network machine accidentally destroys them.  A useful
excuse for anything one has forgotten to send ("Oh, it must have fallen into
the bit-bucket.  I'll send it again".) or did not feel like answering at the
time ("Send it to me again..".). See also backbone.  2.n. A similar place, in
a processing unit, for unwanted information.  Here, in hardware, the bit
bucket collects all the leftover intermediate products of a calculation for
disposal.  In large high-performance machines, a "byte-bucket" or a
"wordbucket" must be used because the bit-bucket cannot be emptied quickly
enough.  3. v. To reject, cancel, or throw away.  As in "We've decided to
bit-bucket this release".
%
bit decay:  n. The tendency of programs to start failing as they get older,
due to changes in the underlying environment or operating system.
%
black hole:  1.n. A person or customer of enormous capacity who can drain the
entire resources of an organisation (such as a branch office).  2.n. A node
on a store-and-forward network that seems to be better at storing files than
at forwarding them.  Usage "IBMVM updates are caught in the KGNGATE black
hole".
%
black layer:  n. Hardware.  See layer.
%
blank:  1.n. A character, printed as a space, and often mistaken for the
absence of a character.  This typically results in its being ignored or
discarded.  (If you can't see it, it isn't there, right?  It's virtual).  VM
was the first major IBM operating system to use the blank as the primary
delimiter in its command language.  See also null.  2. adj.  Of a page in a
manual containing only the top title, page number, footing, and the words
"This Page Intentionally Left Blank".  The most valuable blank pages also
contain the rubric "IBM Confidential" (or something similar).
%
blem:  n. Problem.  Derived from Pro-blem (and possibly Blemish).  Any bug or
problem.  For example "We've encountered a number of blems in the scheduler.
We might have to do a total redesign".
%
blivet:  n. An intractable problem, or a design that can no longer be
enhanced or brought up-to-date.  Something becomes a blivet when it is out of
control.  This usually refers to a program that has been touched by so many
incompetent programmers that it cannot be maintained properly.  From the
World War II military term meaning "ten pounds of manure in a five-pound
bag".
%
blow away:  v. To destroy.  "The editor crashed and blew away all my files".
%
blue:  n. The official IBM company colour, Oxford blue.  There was once a
blue letter on Blue on the HONE system, which said that "...the feature
number 9063 (Blue for all System/370 CPUs and peripherals, called `classic
blue') will have a slightly changed hue which can lead to colour mismatch in
customer machine rooms.  Requests to repaint to the old hue are not
accepted".  See also all-blue, Big Blue.
%
blue button:  1.n. The System/360 or System/370 combination Reset and IPL
button.  2. v. To press the Blue Button.  Used when a system or program fails
to respond to any console command and is somewhere out in never-never land.
See also Big Red Switch.
%
blue cable:  n. The new (thinner) cable required for IBM mainframe computer
connections that run at 4.5 Megabytes per second.  The official name is
Reduced Diameter Channel Cable.  See also boa.
%
blue dot:  n. A small blue paper disk attached to the door-frame of an office
to indicate a member of the cognoscenti.  This curious emblem evolved at
Yorktown as a means to avoid the disordering of one's office (by security
personnel) if one forgot to lock the door on leaving (for any reason).  A
verse from BLUEDOT SONG explains all "So here's the algorithm that our expert
has computed / A blue dot means your office will be locked instead of looted.
/ By this device we hope to end the practice we've protested, / So you can
leave your desk alone and not have it molested".
%
blue glue:  n. SNA (Systems Network Architecture).  That which binds blue
boxes together (official definition).
%
blue layer:  n. Systems control (operating system) software.  See layer.
%
blue letter:  n. The document once distributed by the Data Processing
Division to announce a new product or education course.  So named because it
was printed on blue paper, it contained the generalised product description
and the specifications that were used to make the marketing representatives
experts.  When DPD became NAD (National Accounts Division), NMD (National
Marketing Division), and ISG (Information Systems Group), the blue letters
changed colour (as did the Peach Letters of the Small Systems announcements).
They are now all printed on ivory coloured paper (called buff or bleach [Blue
and Peach] by some).  It is now fashionable to call the letters "Ivory
Letters" to illustrate one's ability to change with the times, but real data
processing old-timers will invariably refer to them as Blue Letters.  See
also announce.
%
blue money:  n. Internal budget dollars, used to purchase an item from
another IBM organisation.  This is used mainly by product planners.  Its
corollary is real money (or, in the monochrome USA, green money), which is
needed to buy things from the outside world.  Real dollars are worth much
more than blue dollars, and nothing can stop a proposal faster than pointing
out how many real dollars it will cost.  Alternatively, a proposal is much
more likely to be approved if "the total cost is all blue dollars".  See also
funny money.
%
blue sky:  adj.  Not inhibited by practicality, possibility, politics, or
popular trends.  For example "A computer system that is actually Easy To Use?
That's real blue sky!" See WIBNI.
%
blue solution:  n. A system to solve a customer's particular requirement or
application that uses only IBM hardware and software.
%
blue suiter:  1.n. Someone from a more formally[over-?] dressed part of the
IBM culture.  That is a) IBM marketing representative (when used by those at
HQ); b) IBMers at HQ (when used by those in a development laboratory); or c)
IBMers not at Research (when used by those at Research).  2.n. An Officer in
the United States Air Force.  (When used by an IBMer at the original Westlake
location, in California, which used to be visited by many USAF personnel.  As
that Westlake is now defunct, these now trek to Boulder instead.)
%
blue wire:  n. A fix (correction) to a hardware card.  Required to repair
damage accidentally caused by deleting a pin while installing an Engineering
Change.  Also used if the EC team runs out of yellow wire.  See also purple
wire.
%
bluebird:  n. A sale that comes in through the window, that has not been
"worked for".  For example, a hitherto unknown customer walks in and orders a
complete System/370.  In India, they may be known as "Fairy Bluebirds".
%
bluespeak:  n. The language and jargon used by IBMers, especially when the
jargon is different from that used by those employed by other companies.  For
example, DASD or file (others use disk).  See also IBMJARG.
%
boa:  n. One of the big fat cables that connect the parts of a computer and
lurk under the raised floor of all large computer installations.  Possibly so
called because they display a ferocious life of their own when you try to lay
them straight and flat after they have been coiled for some time.  It is
rumoured that System/370 channel cables are limited to 200 feet because
beyond that length the boas get dangerous.  (Also note that one maker of
computer cables in the USA is the Anaconda Copper Company.)
%
board games:  1.n. Exercises played by the designers of any new keyboard (not
just IBM's!) in order to retain an advantage over the end users.  The schemes
employed can be so perverse that they defy belief at times.  2.n. Invisible
decisions taken by members of some board or committee, usually with
all-too-visible results.
%
board wirer:  (bored wire-er) n. An early breed of programmer who programmed
accounting machines of various kinds by patching connection wires into a plug
board.  See grey elephant.
%
boat anchor:  n. A hardware project or tool that, despite the investment of
resources far beyond the original budget and schedule estimates, fails to
meet even minimal objectives.  Applied especially to "heavy" equipment.
%
bogey:  n. A target, especially a difficult or unpleasant one.  This is used
during planning cycles when headcount or budget allocations are being cut.
The new target is referred to as a "bogey" and is the value that has to be
matched in order to be within the authorised resource limits.  "We are still
three headcount over bogey in '87!" Probably from the golfing term (usually
one stroke over par on a hole), with overtones of the 1940s slang term for
enemy aircraft.  Also dollar bogey, a budget limit.
%
bogue, boge:  (rhymes with rogue) adj.  Of an idea or project having little
merit.  From "bogus".
%
boil the ocean:  v. To attempt something too ambitious.  This phrase is used
to throw (cold) water on something the speaker perceives as an overly
ambitious proposal, even though no technical case can be built for
disapproval.  For example "Your problem is that you're trying to boil the
ocean".  This phrase dates from World War II, when Axis submarines were
severely damaging Allied shipping.  The story goes that a high level naval
meeting was held to discuss the problem, during which an admiral suggested
the solution of boiling the ocean to force the submarines to the surface.
Everyone thought this was a wonderful idea, except for one relatively junior
officer, who asked how this was to be done.  The admiral replied "I gave you
the idea, it's your job to work out the details!"
%
boiler plate:  n. Content-free portions of a presentation included to capture
the attention and otherwise distract the listener from any real issues.  Also
applied to standard parts of a document or program that contain little
information (copyright notices, for example).
%
bomb:  v. A synonym for crash.  (In the USA only - to other English speakers
the word conveys the opposite meaning when used descriptively, as in "That
sports car goes like a bomb!")
%
boondoggle:  1.n. A conference (or other meeting that involves travelling)
with an admixture of both pleasure and business.  To be a true boondoggle,
the trip must be paid for by IBM.  To be a super-boondoggle, it should be to
Southern France, Florida, or anywhere in the Caribbean.  2.n. A group of
people, often a task force, getting paid but doing nothing productive for a
related group - or for corporate revenue.  They may look and act and sound
very busy.
%
boot, bootstrap:  1.n. A program used to start up a computer.  From the
expression "to raise oneself by one's own bootstraps".  Early IBM computers
were started by pressing the blue LOAD button.  This simply made the machine
read one card into memory and then branch to the memory location where that
card image had been placed.  The first card, therefore, had to contain all
the instructions necessary to get the machine to read the next card or cards
(as required) which contained the rest of the program which in turn, when
complete, could then read in the production program or (later) the operating
system.  This initial, bootstrap, program typically took two or three cards
(160-240 bytes) and hence was called a boot deck.  An early computer sport
was the writing of one-card self-loading production programs; an 80-80
listing was possible for the IBM 1401.  2. v. To start up a computer, using a
bootstrap program.  Also, in general, to start or restart a computer
operating system.  In the sixties, and even on today's mainframes, this was
done by pressing the blue button.  See also Big Red Switch, IPL.
%
bottom line:  n. A term used (mostly by managers) to reveal a strong desire
to bypass understanding of a proposed solution in favour of a simplistic
quantification of it.  Probably a reference to the totals line at the bottom
of financial reports.  As in "I don't want all these pros and cons, just give
me the bottom line".  Higher level managers may interchange use of this term
with net it out.
%
box:  1.n. A piece or collection of hardware large enough to form a
free-standing unit.  "The Mass Storage Subsystem was an interesting box".
This term is often used when the term "unit" may be ambiguous.  For example,
in a 3380E disk unit there are four disks and eight access arms.  Saying that
the 3380E can hold about 8GBytes per "unit" can be misleading if the listener
confuses "units" with access arms (which correspond to one I/O address each)
or to disks (which have two I/O addresses each).  2. v. To isolate a piece of
equipment from the rest of the system for diagnostic tests.  See fence out.
3. v. To put in a packing box (because the equipment has broken or has become
obsolete - in the latter case pine boxes are preferred).
%
boxology:  n. The art of drawing pretty diagrams using the "box" characters
(actually box part characters) in monospace fonts.  Also known as character
graphics.
%
bracket:  n. A collection of messages.  This term is an invention in IBM
communications, and part of the Systems Network Architecture.  A bracket is a
group of messages exchanged between two communicating parties that is deemed
to constitute a logically separate unit such as a "transaction".  Marker
flags are sent with certain messages to indicate the start or end of a
bracket.  Brackets offer plenty of scope for getting out of step and
producing nasty problems called "bracket violations".
%
brain check:  n. An error that occurs while presenting information to a
computer (or to another person) and that is not caused by a simple keyboard
entry error (cf.  finger check ). Often used in the following way "Sorry
about that, but it was only a finger check, not a brain check".
%
brain dump:  n. An alternative term for core dump.
%
branch to Fishkill:  n. Similar to branch to Owego, but starting in
Poughkeepsie.
%
branch to Owego:  n. Any unexpected jump in a program which produces
catastrophic or just plain weird results.  This phrase originated in
Endicott, which is just down the road from the rival Owego (Federal Systems
Division) site.  For example "Ah ha!  My base register got clobbered that
made the program take a branch to Owego!" For the record, the name Owego
comes from ah-wega, an Indian name meaning "where the river widens".
%
brass tag:  n. A small plate (originally made of brass, but now usually made
of self-adhesive plastic) that shows the IBM serial number (stock number) of
a piece of (non-IBM) capital equipment.  It was considered a serious offence
to remove the brass tag from a piece of equipment, though readers report that
they sometimes kept as a souvenir the brass tag from a much-loved machine
when it was scrapped.
%
breakage:  n. The extra people that must be added to an organisation because
the action plan has changed.  Every planned change causes breakage - usually
more than unplanned changes.
%
breakthrough:  n. A solution to a challenge which had no obvious resolution.
Usage "This is your goal; we need a breakthrough".
%
brick:  n. A Digital Communication System (DCS) Portable Terminal (PT) used
by most US IBM NSD Customer Engineers (CEs) to record and communicate their
activities and to send messages back and forth.  The technology has led to
the current ARDIS offering.  The PT is about the size, and weight (0.8kg,
28oz), of a brick and is equipped with an audio annunciator for attracting
attention.  Eack brick is capable of operating in RF (Radio Frequency) mode
or TELCO (Telephone Company) mode.  In RF mode it is linked, via a network of
remote antennae, to one of the 12 Area Communication Centers (ACCs)
throughout the US which receive customer service calls.  In TELCO mode the CE
dials into the ACC directly.  Bricks distinguish IBM Customer Engineers from
service representatives from other firms (who carry mere pagers).
%
bridge:  n. Unsubstantiated facts used to explain one set of data in terms of
another.  A bridging exercise is a procedure whereby one takes two different
and sometimes independently generated sets of information, usually numbers,
and relates them in some way to explain the differences.  Upon being
presented with a set of data, the manager making a decision involving that
data usually asks for a bridge from the current set to the last acceptable
set of data.  Generally the bridging exercise is unnecessary for anyone
involved in the decision, but the need for a bridge provides the manager with
a convenient excuse to delay the decision.  "I cannot make a decision on that
without a bridge to the last estimate".  The most useful bridge is so
comprehensive that it is too complex to be understood by anyone but the
person who created it - and hence is ideal for use in reports to higher
levels of management.
%
brimburn:  n. A confusion whose symptoms are reminiscent of a mild
schizophrenia.  A result of changing hats too fast in a new position.
External symptoms include the taking of the opposite side to that held in the
previous position.  Especially prevalent in those newly appointed to
positions of responsibility.  Secondary symptoms include an inclination
towards pronouncements such as "that is true, but you must understand both
sides".
%
bring the system to its knees:  v. To overload a computer so that its
response time is dramatically worse (longer) than usual.  "Everything was
fine until he started to run MVS as a guest system - that's what brought the
system to its knees".  See also thrash.
%
bring up:  n. To restart a system (usually by IPL) after a failure or a
normal period of disuse.  To bring a system to an operative (up) state.  [A
curious choice of phrase, given some of its more common meanings.]
%
bring up file:  n. A repository for information needed at a later date.
Usage "Let's put that request in the bring up file".
%
btw:  (by-th'way) abbreviation.  By The Way.  An abbreviation used in
electronic mail to speed typing, and hence properly entered in lowercase.
Also obtw, "Oh By The Way".  See also wrt.
%
buck slip:  n. A routing slip listing the names of the members of a
department.  Used to make the loss of correspondence (or delay in delivery)
more organised.
%
bucket:  n. A collection; usually a collection of programs, tests, or fixes.
"Please send me the bucket for release 3".  See also bit-bucket, regression
bucket, test bucket.
%
bug:  n. A very broad term denoting a defect in either hardware or software.
Some bugs can be detected and may interfere with customer (or IBM) use of the
product.  Other bugs may lie dormant and hatch for a Watson's Law event.
Much effort is and will continue to be spent forcing bugs to the surface and
removing them or otherwise eliminating any ill effects they cause.  The
ultimate management question is "Have you really removed the last bug from
our product?" The required workers' reply is "Oh, surely we have found the
last bug?!", delivered in unison.  [This is not an IBM term, having been in
use since 1889 or earlier, but is included here for completeness and
cross-references.]
%
build:  v. To assemble software or hardware systems.  This is used fairly
conventionally for hardware (as in "build a new CPU"), but is used far more
carelessly when describing software systems.  When all the components of a
large program are assembled together to make a whole, the process is called
building.  If the resulting system is large and complex, the verb is often
elevated to the status of a noun, as in "Let's start testing the new build".
%
build-to-order:  adj.  Of a hardware product manufactured, or to be
manufactured, following customer orders.  Often, some special feature (like
frame doors of the proper colour) is unavailable - which leads to long
delivery delays.  Sometimes, however, special orders can be processed more
rapidly than those for massproduced (build-to-plan) items, which can have a
large backlog.  It is reported that when 3380 disk units were scarce (in
1984/5), an internal customer mistakenly ordered brown 3380s (which are BTO
models) rather than the standard blue/White variety.  Much to their surprise,
the units were delivered two months later; other departments had been waiting
for their blue ones for more than a year.
%
build-to-plan:  adj.  Of a hardware product manufactured, or to be
manufactured, independently of customer orders.  Since forecasts (on which
the plan was based) have the knack of being inaccurate, this technique can
lead to delivery delays or overfilled warehouses.  See build-to-order.
%
build plan:  n. A proposed or committed schedule for the completion and
assembly of a software system.  See also build.
%
bullet:  n. One of a list of items to be emphasised, usually marked by a blob
(bullet) alongside it on a foil.  "And the next bullet is absolutely
vital.."..  See also key.
%
bulletize:  v. To convert a proposal, argument, or result into a list of
items for a foil (which may or may not be preceded by bullets).  Implies
extracting the essence of an argument, but in reality means emphasising the
most politically acceptable items from a proposal.
%
buns on seats:  n. A measurement of sales performance peculiar to regional
sales staff departments ("Customer Centers").  Rather than sales dollars,
which are difficult to attribute to a regional sheep dip session, the staff
count the number of people who attend mass-marketed seminars.  Staff members
sometimes suspect each other of inviting relatives and the unemployed, with
promises of Costa Rican coffee and mock-Danish pastries.
%
burden:  n. The additional costs, or overhead, above an employee's salary
that when added to the salary make up the true cost of an employee to the
company.  Typically (but rather dependent on the country of employment) the
burden is approximately equal to salary.
%
burn:  v. To make a copy.  "If you can wait a minute, I'll burn one for you".
The term is used both by engineers (when copying a programmable read-only
memory (PROM), which requires the melting of fusible links in the circuitry)
and by others when copying papers.  This latter usage can be dated to the
late 1950s, when the dominant method of making copies was "Thermofax".  This
process used infra-red radiation to transfer copies to heat-sensitive paper.
See also ibmox.
%
burn-in:  v. To "condition" a piece of hardware (especially an integrated
circuit) by running it for some time (often at an unusually high
temperature).  Many of the failures in computer equipment occur when it is
first used burning-in is an effective technique for ensuring that these occur
before the equipment is used for a critical task.  See also bathtub curve.
%
burn sand:  v. To personalize EPROMs or gate arrays, programming them by
electrically blowing (burning-out) fusible links on the silicon chips.  Usage
"We need to ensure that low level design is complete before we commit to burn
sand".
%
business case:  1.n. Economic (commercial) justification.  Asking for the
business case is an effective wet blanket to throw on most hot projects.  2.
v. To make such a justification.  As in "Sorry, Joe, we are still
business-casing that project".
%
buzz word quotient, BWQ:  n. The proportion of words in a conversation or
document that are buzz words (jargon words).  For example, if every fourth
word in a conversation is a buzz word, it has a BWQ of 0.25 or 25%.
%
byte:  (bite) n. One character of information, almost always consisting of
eight binary digits (bits).  In nearly all True Blue computers, a Byte is
realised as more than eight bits - the extra bits (or parts of bits) being
used for error checking.  The term "Byte" originated in 1956 during the early
design phase for the IBM Stretch computer.  Originally it was described as
consisting of from one to six bits (typical Input/Output equipment of the
period used 6-bit chunks of information).  The move to an 8-bit byte for
Stretch happened in late 1956, and this was the size later adopted and
immortalised by the System/360.  The term was coined by mutating the word
"bite" so it would not be accidentally misspelt as "bit".  See also nybble.
%
cable together:  v. To assemble a system on an ad hoc basis.  "They just
cabled together whatever boxes they could find".  [A pun on "cobble
together".]
%
cabling system:  n. A new wiring standard that is intended to allow the
interconnection of all IBM terminals, PCs, and communication devices.  It is
also the physical support of the token ring.  Installing it should relieve
systems administration personnel from the boredom generated by the
over-familiar coax wiring.
%
cache:  n. An area of memory, usually faster or more readily accessible than
the rest of the memory, that is used to hold instructions or data that are
(or are expected to be) referred to frequently.  First used in the IBM
System/360 Model 85 (1968).
%
calendarize:  v. To put an appointment into one's calendar.  This expression
replaces the more traditional idiom, pencil in, in the sentence "let me
pencil that in for Thursday".
%
call-taker:  n. An instructor in a marketing education class who takes on the
role of a customer taking a call from the (trainee) Marketing Representative.
In this scenario, an inexperienced student pretends to be a seasoned rep
while an inexperienced instructor pretends to be a customer.  Full of
imagination, they both sit in an interview room, making believe that it has
long been a business office, and earnestly engage in an attempt to satisfy a
hypothetical customer requirement by discussing pieces of equipment which
neither has ever seen or used.  The student is assessed on his or her ability
to continue to breathe while fumbling through notes and brochures.  The
instructor (call-taker) is judged on his or her ability to stay awake after
playing the same role twelve times a day.
%
candy-striped:  adj.  Registered IBM Confidential.  Refers to the Red and
White diagonal markings on the covers of such documents.  Also used as a verb
"Those figures have been candy-striped".
%
card:  1.n. A piece of cardboard about 90mm by 215mm that held information
which was encoded by patterns of small rectangular holes punched through the
cardboard.  The standard IBM (Hollerith) card was made the same size as paper
currency of the day, and held 80 columns of data encoded as one character per
column (though many other kinds of coding scheme were used).  Other sizes of
card were also used, with either rectangular or circular holes.  The standard
80-column card still influences IBM products, and indeed the whole computer
industry; for example, displays commonly allow 80 characters in a row, and
many reference documents (especially "Quick Reference Cards") have similar
dimensions to a punched card.  See also chip, green card, spindle.  2.n. An
electronic printed circuit board.  "The problem determination procedure lets
all faults be isolated to a single card".
%
card-holding manager:  n. A manager who manages employees (rather than one,
such as a program manager, who is a manager in title only).  Until recently,
the personnel profile of an employee was recorded on a computer card; this
was held by the manager of that employee.  See manager.
%
career develop:  v. To promote or move to another job, especially if the
employee is not entirely happy with the change.  Usage "We should career
develop Jack; he's too bright for the rest of the team".
%
career limiting remark:  n. An undiplomatic comment directed at one's
manager, or at one's manager's manager.
%
carriage control character:  n. A character, usually in the first column of
each line of a file, that controls the way in which the line is to be
printed.  Originally, this character controlled the movement of the printer
carriage almost directly.  Nowadays it is usually processed by software to
produce some indirect effect.  See also skip to channel one.
%
carrier product:  n. The first product that includes an implementation of
some new feature of an architecture, especially of SAA.
%
carve up the business:  v. To divide up and parcel out management
responsibilities.  Most often used at the headquarters level "After we carve
up the business we will know where we stand".
%
cascade:  v. To distribute information rapidly, using a hierarchy of
presentations by senior managers.  As in "Please cascade this to your people
this week".
%
cast in concrete:  adj.  Immutable.  Used when specifications are frozen and
are therefore unchangeable.  This takes place a few days before the first
prototype is available for general usability testing, so minimising the work
of the development group.  Effectively acts as a wet blanket should further
urgently needed changes be proposed.
%
cast in jello:  adj.  Not cast in concrete, still not firm or decided.  On
some projects, describes any decision made without management approval; on
some others, any decision.  ["Jell-o" is a brand name, in the USA, for
gelatin-based desserts (usually fruit-flavoured).]
%
casters up mode:  n. Complete breakdown, as in "The 1130 is in casters up
mode".  Engineers' equivalent of the term "all four feet in the air",
referring to a piece of hardware which is totally non-functional and of use
to neither person nor beast.  See also down, belly up.
%
catalog:  1.n. A directory of files in an operating system.  2.n. A list of
packages available on an automatic software distribution service.
%
catcher:  n. A program that executes at locations remote from a central site
and which receives and installs programs and data from the central site.  A
kind of shadow.  The term comes from a North American game called "baseball".
See pitcher.
%
caveat:  n. A warning, given during an oral presentation.  This is a
communication technique, favoured in NCD, that affords a presenter the
opportunity to give an illusion of speaking frankly and candidly to an
audience.  Done well, the caveat will relax the defences of an otherwise
critical audience, lulling it into accepting the token statement at face
value.  "The customer must first effect an operational SNA environment.  This
is not always an easy task, but has been done in one day at several
accounts".
%
center of competency, COC:  (see-oh-see) n. A group of people who claim to be
experts in some particular topic.  This title follows the name of many
support groups and development departments, and is almost always
self-bestowed.  The term suggests a level of expertise, importance, and
involvement generally not associated with the group (hence the perceived need
for the title).  Adding the COC tag to the function name of any department
automatically increases the headcount and the travel budget of that
department, but usually without a proportional increase in competence.
%
central electronics complex, CEC:  (keck) n. The central processing unit
(CPU) of a large computer ("CEC" sounds more impressive than "CPU").  This
term was prohibited by CYA enthusiasts in 1978, who feared that the term
would be trade-marked.  In 1987 it crept back into general use, both in
connection with the 3090 (where it refers to the business end of the 3090
Processor Complex, i.e., everything except the support bits such as the 3092,
3097 and 3089) and with the System/88 (whose engineers refer to the number of
CEC slots in various chassis).
%
challenge:  n. Something difficult.  A challenge is climbing a mountain (or
bottoming a cave) and is not related to "work" at all.  In IBM this term is
often mistakenly used to mean "Big Problem".
%
change control:  n. A method for documenting and controlling the changes to a
system or environment, sometimes relying on pieces of paper.  One of the
System Management disciplines, from which DP centre staff derive the warm
feeling that they are in control of their computer installation.  Often known
sardonically (by the users who must actually live with the insidious
overheads generated by the various implementations of the discipline) as
"blame control".
%
charm school:  n. New Manager School.  Ambitious careerpersons must learn to
direct their friends instead of swill ale, wine, or fruit juice with them.
It is observed that some charm schools teach "ugly" instead of "suave".
%
chauffeur driven:  adj.  Of a software system developed using a standard
product that has had a new (usually better) end user interface provided by an
expert to hide the original interface.  Also used to hide the extraordinary
number of options provided with much computer software.
%
check:  n. A serious error.  From machine check.  A check is an error deemed
sufficiently serious that a light (called a "check" light as it could be
easily checked at a glance) was lit on the front panel of the computer.
Usage "The CPU took three checks before lunch".  Also used for software
(program checks).  See hit.
%
checkbook programming systems:  n. A systems group that hires an outside
vendor to produce software instead of having it written by IBM programmers.
A group whose achievements are proportional to budget rather than to skill or
to talent.
%
chicken book:  n. A gentle, user-friendly, introductory guide to a piece of
hardware or software.  Especially used of the PC-DOS User's Guide, so named
because of its pictures of "cute" chicken-like birds and perhaps because its
audience was expected to be timid and fearful.
%
chiclet keyboard:  n. A keyboard whose keys are fabricated from small
rectangular pieces of rubber-like plastic that look like pieces of
chewing-gum [Chiclet is a brand-name and a Spanish generic term for
chewinggum].  Used to describe the original PCjr keyboard.
%
chinese binary:  n. column binary.
%
chip:  1.n. The small rectangle of cardboard created by punching a hole in a
card.  See also Chad Age.  2.n. An integrated circuit.  One chip from a wafer
of silicon crystal.  See also glass.
%
chiselled in granite:  adj.  cast in concrete.  Used in the Eastern USA near
the Granite Mountains of Vermont.
%
chocolate:  adj.  Enhanced flavour.  That is, of a program modified and
improved.  Rare.  See flavour, vanilla, mocha.  See also spinning chocolate.
%
clean up:  1. v. To improve a sloppy program, system, or procedure by
redesign or by rewriting sections of the code.  "We have to clean up the SPIE
exit".  A cleanup should convert decadence to elegance, and sometimes does.
2. v. To recover space on a disk by erasing old or redundant data.
%
clone:  n. A copy of a computer (almost always an IBM PC).  Imitation is said
to be the sincerest form of flattery; in recent years there have been few
clones of other manufacturers' personal computers.
%
close of business:  n. End of the working day, typically 5pm local time.
%
closed loop:  n. See loop.
%
clutch point:  n. A periodic opportunity to do something.  As in "missing the
clutch point".  From the days of mechanical card readers, which could only be
activated at one point in their mechanical cycle.  If the signal to activate
was too late, the controlling program had to wait a full cycle before trying
again.
%
co-op:  n. Co-operative education student.  Usually a college student, in the
USA, who works for IBM for a term (semester), and sometimes longer.  Co-ops
very often get good and interesting projects to work on, but the short straw
can be mundane work such as making an inventory of ceiling tiles.
%
coathanger:  n. A computer terminal given to a reluctant old-timer IBM
manager who does not believe in dataprocessing.  This is used as a convenient
object over which to throw the animal fur coat in order to warm it for
wearing home.
%
code:  n. The statements, instructions, or binary representation of an
algorithm or procedure.  Any program in source or other form.  microcode is
the lowest level of software controlling a computer.  machine code is the
next level - the documented instruction set of a computer.  assembler Code is
next, where symbolic names may be used for the instructions.  Object Code
(see OCO) is the result of compiling assembler (or higher) level languages.
All other programming languages are other more or less obscure ways of coding
a clear algorithm into something that a computer might understand, and all
programs are referred to as Code.  This may also be used as a verb, of
course, and a coder may be seen coding code.  See also line of code.
%
code freeze:  n. The point of the development cycle after which no further
changes may be made to the code.  This freezing is needed so that the product
is no longer a "moving target" for those people trying to add the final
polish to documentation or sales brochures.  It may or may not be a true
freeze - sometimes corrections and bug fixes are still allowed.  Sometimes
preceded by a code slush.
%
code name:  n. The name used to designate a project (or future product) to
obscure the purpose of the project from casual observers and other IBMers.
The code name of an especially famous project can move into the vernacular
(for example, see Winchester).  When a suitably large number of IBMers know
what is concealed behind the code name, the product is announced in order to
change its name to a four-digit product number.  A clever product manager
always chooses a code name which lends itself to a descriptive series, and
hence makes follow-ons a natural possibility.  For instance, a project COLLIE
might spawn a CHIHUAHUA (wristwatch version) and a NEWFOUNDLAND (mainframe
version).  See also announce, FCS.
%
code triple point:  n. A code freeze that exists on paper, or in someone's
imagination, but is not matched by reality.  From the Physics term the
pressure and temperature at which the solid, liquid, and gaseous phases of a
substance can co-exist.  Code at triple point similarly exists in three
phases solid, fluid and vaporware.
%
coffee break:  n. An unscheduled failure in a computer system.  Used to
describe a stoppage or crash that mysteriously occurs around the time that
users or operators are in need of refreshment.  Also used to describe any
unexplained failure in a computer system.
%
coffee game:  n. A procedure followed to determine who among a group of
people is to pay for a round of cups of (instant) coffee.  A religious
ceremony practiced at various IBM locations (notably the Glendale Laboratory
at Endicott, NY) in which groups of people play a simple but skilful game of
chance to stretch a fiveminute trip to the coffee machine into a half-hour
break.  Coffee games often attract large followings, with the most addicted
devotees refusing to drink coffee unless it has been properly played for.
Games are usually played among a set group of people, with a game taking
place every time anyone in the group develops a thirst.  Coffee gaming has
developed its own special jargon.  This is outside the scope of this
dictionary, being a major research project in its own right, but some idea of
its flavour may be gleaned from the following A "dip" indicates that a person
has lost a game, a "double dip" is two losses in one day.  A "triple dip" is
known as a "Pat Mitchell Special", in honour of a well-known Endicott ice
cream parlour.  [Also used as a verb.]
%
cold pricklies:  n. A nagging suspicion that somewhere one has overlooked
something critical, and will be punished for it.  See warm fuzzies.
%
cold start:  n. A restart without restoring the previous state of the
operating system.  On VM, this causes the loss of all spool files, and is
therefore often used as an excuse for a missing VNET file "You didn't get the
memo I sent you?  There must have been a cold start somewhere".  Also used to
designate problems in resuming normal work "After his week in Yosemite, he
had a two-day-long cold start".
%
column binary:  n. A scheme devised by the SHARE user group, and implemented
in the "SHARE Loader", for encoding binary data on punched cards in columns,
rather than in rows.  The IBM 701, 704, 709, and 7090 computers read cards as
rows of words, 9-edge first, two 36-bit words a row (in columns 1 through
72).  With the improved scheme, three columns (of 12 rows) were used for each
word.  As an early example of improving the human interface to machines it
was remarkably successful, because it let users punch their patches
relatively easily on an IBM 010 or IBM 011 card punch.
%
come out of the bottle:  v. To become enraged, or to make unreasonable
demands.  As in "When I told him we wouldn't have it ready until next week he
came out of the bottle".  The proper term for appeasing someone who has come
out (or is out) of the bottle is "back in the bottle", as in "Have you got
him back in the bottle yet?" The origin of this phrase is unconfirmed, but it
may be derived from the tale of the Fisherman and the Genie in the Arabian
Nights.  See also uncork.
%
comeback meeting:  n. A meeting called by an Executive to follow-up on
actions requested at an earlier meeting.  "The comeback meeting to the
Director is scheduled for Tuesday 9th May".
%
command language:  n. A set of magical incantations that may be used to
instruct a computer to perform wondrous things.  Can bring great blessings on
the user; but like all good magic, misuse or use by the ignorant (see naive
user) can bring great woe.
%
comment out:  1. v. To make a section of source code ineffective by putting
it between comment separators.  This allows the effect of that code to be
determined empirically, by omitting it without actually destroying it; a
powerful and effective debugging technique.  2. v. To make someone's remark
ineffective by making a nasty comment about the remark (or his or her
expertise).
%
commit plan:  n. See Fall Plan.
%
commit time:  n. (Used by some Field personnel.) The latest time when one can
leave the IBM building on a customer call without appearing to be leaving
early for home.  As in "If I don't leave for a customer location before
commit time, I have to stay until 5pm".
%
commonality:  n. The common ground between two plans or designs.  "OK, what's
the commonality between your proposal and hers?"
%
communication:  n. The art of obscuring information with jargon.  The
following example comes from a book describing (appropriately enough) a
communications protocol "All PIUs that have a DAF containing the address of
this LU and whose OAF matches the partnernetwork-address field in an NLX
associated with the NLB for this LU are queued to the NLX that represents
this unique OAF and DAF pair".
%
compatibility box:  n. A subset, or mode, of OS/2 under which PC-DOS programs
can be run; effectively an operating system within an operating system
(though not in the sense that VM allows).  The compatibility box goes to
great lengths to permit almost any PC-DOS program to run in it.  It emulates
a DOS 3.3 (or later) system, in which old DOS 1.0 calls are still provided.
Since DOS 1.0 itself emulates parts of CP/M, some CP/M programs theoretically
can still be run under OS/2.  See also penalty box.
%
compatible:  1. adj.  Sufficiently similar to some other piece of hardware or
software (often an earlier release of the same product) that moving from one
to the other is relatively painless.  Note that the movement, like stroking a
dogfish, is unpleasant in either direction, but is especially so in the
direction not intended by the designer.  See also follow-on.  2. adj.  Not
compatible.  As in "A compatible subset, with extensions".
%
computer security audit:  n. The day on which an independent security audit
team descends on a location and attempts to find the security problems in the
computer system there.  This is either a) the day before which all passwords
are changed and confidential files encrypted [best case], or b) the day after
which all passwords are changed and confidential files encrypted [worst
case].
%
concern:  n. A formal indication from one group to another that the first is
(very) worried about some action by the other.  To start a communication with
the words "I have a concern with your..". is a sure way to cool a friendship.
See issue, non-concur.
%
concur:  v. To give an irrevocable (often written) agreement.  "Product
Assurance concur (that the product be shipped)".
%
conference cronies:  n. The 10% of contributors who produce 90% of the
contributions to a conferencing facility.
%
conference disk:  n. A disk containing documents (files) that are mostly
forums, which are managed by a conferencing facility.
%
conferencing facility:  n. A service machine that allows data files to be
shared among many people and places.  These files are typically forums on
particular subjects, which can be added to by those people authorised to take
part in the conference.  This allows anyone to ask questions of the user
community and receive public answers from it.  The growth rate of a given
conferencing facility is a good indication of IBMers' interest in its topic.
The three largest conferences are the IBMPC, IBMVM, and IBMTEXT conferences,
which hold thousands of forums on matters relating to the PC, VM, and text
processing, respectively.  These are all open to any VNET user.  See also
append, forum, service machine.
%
conscience:  n. Person responsible for a task.  As in "You are my conscience
regarding the integrity of that plan".  A favourite among younger senior
managers with regard to experienced members of their staff.  The term implies
a deference to the skills of the other, and also a certain delegation of
responsibility.
%
content:  n. The central ideas of a document, as distinguished from its
"style" or "layout".  When a document is sent out for review it is understood
that one is to review its content, rather than its presentation.  (And if one
can figure out what the author meant to say then the content is better than
average.)
%
control unit:  n. A piece of hardware that controls a number of one type of
peripheral unit, such as displays, tape drives, or disks.  A control unit is
supposed to relieve the main processing unit from the more menial tasks
involved in managing the peripherals.  For display terminals, especially, it
may also have an uncanny ability to increase system overhead time (and hence
response time) by several hundred percent.
%
converge:  v. To take two dissimilar projects and gradually change or evolve
both of them until they can be replaced by a single project or product.  A
concept drawn from non-Euclidean geometry, wherein parallel (or even
diverging) lines are seen to intersect.  As in "Let's keep both projects
going and converge them in Release 3".
%
cook chips:  v. To produce multilayer chips for use in complex modern
computers.  This refers to the processing of the silicon wafers, which
involves repeated baking in special ovens.
%
cookbook, cook-book:  1.n. Some official document which exemplifies the
bureaucracy involved in getting a product out of the door.  For example, a
CTP (Comprehensive Test Plan).  Also used as an affectionate term (like
bible, q. v.) for some master reference document.  2. adj.  Describing (in
great detail) a procedure for a person to follow, down to what commands to
type, and when.  As in "This guide has a cookbook description of IPLing a
system".
%
cooperative processing:  n. Processing carried out in two or more places,
usually a personal computer (or workstation) and a larger "host" computer.
There is an implication of close execution interlocks between the parts of a
single application.  Coined circa 1985.
%
core:  n. The main memory of a computer.  Usage "Is the transient in core at
the time ?" A reference to the ferrite cores employed as the main storage
medium for early computers, rather than a synonym for "central".  In faddish
circles people sometimes avoid this term in favour of the more general
(though less clear) terms "storage", "main store", and "backing store".  See
also doughnut.
%
core dump:  n. A complete briefing consisting of all that a person knows
about a subject.  Also brain dump.  Usage "Give me a five-minute core dump on
SNA before the staff meeting".  See core, dump.
%
core time:  n. That part of the day in a flextime scheme during which all
employees are expected to be present.  This is also the hours during which
meetings may be held; for example, 09 15 through 16 25 in the UK
Laboratories.
%
cost:  n. The cost to IBM to build a product (usually hardware).  (As opposed
to its price, which is its nominal selling price.)
%
counsel:  v. To reprimand.  An employee is counselled after making a mistake
that is too serious to overlook or to be handled informally.  "Was he fired?
- No, but he was severely counselled".
%
counter-strategic:  1. adj.  Not the official policy.  Applied to suggestions
that one would like to ignore.  "Not the basket in which IBM has placed its
eggs".  2. adj.  Not the published official policy.  That is, causing
embarrassment to those who are responsible for what is strategic.
%
crash:  1. v. To halt in an unrecoverable manner, when not expected.  Almost
never preceded by a warning message except when the crash is deliberate.
Usually indicates human error in hardware or software (or even firmware).
"The system has crashed AGAIN".  2.n. The event of crashing.  "That was a bad
crash".
%
creationism:  n. The principle that large systems are created from thin air
in a single step.  A superstitious belief devoutly held by many product
planners [especially in warm climates?].  See evolution.
%
creeping featurism:  n. The consequence of adding new features to old,
backward, user-hostile products until so many new options, functions, and
"enhancements" are added that all coherent concept of the intended function
and use of the original product is lost.  A cancerous form of evolution,
usually indicative of human failings or organisational ineptitude.  [Not
originally an IBM term, but widely met and used.] See also creationism.
%
crisp up:  1. v. To add meaningful content, or to make more impressive or
flashy (usually the latter).  As in "We'll have to crisp up this presentation
before the Director sees it".  2. v. To remove meaningful content, to reduce
to the essential.  As in "We'll have to crisp up this presentation before the
Director sees it".
%
crit sit:  n. "Field-ese" for critical situation.
%
critical service:  n. A hot bug fix.  See service.
%
critical situation:  n. A customer who has a (real or perceived) serious
problem with IBM hardware or software, for which there is no (immediately)
available fix.  Unless a fix is provided, the customer is threatening to call
the Chairman of the Board and/or remove all his IBM equipment and cancel all
orders.  This usually results in the Branch Manager demanding that the
programmers and engineers who own any IBM products even remotely involved
with the customer's problem jump on airplanes and converge on the account.
Normally all but one (and possibly all) will be wasting a trip, but the
customer will be impressed by the show of force, and the problem will get
fixed.  See also account situation.
%
critical unresolved dependency:  (cud) n. A reliance of one organisation on
another to perform some action or provide some resource that is crucial to
another's plans, where the provider has not yet agreed (indeed, may not be
aware of) the dependency.  Usage "We can ship our new box in eight months,
but we do have a CUD on the Programming Center to write the operating system
by then".  [Something for those guys to chew on.]
%
cubicle:  n. A standard Domestic office, which has a shape that is
approximately an eight-foot cube.  Note that most dictionaries define cubicle
as a "sleeping compartment", though it is rumoured that some have outside
awareness.
%
cubie:  n. The person with whom one shares a cubicle.
%
currency symbols:  n. The two characters ('5B'x and '4A'x) in the EBCDIC
coded character set that represent the primary and secondary currency
symbols.  In the USA these are represented externally by the dollar and cent
signs.  In the UK they are shown as the pound sterling sign and the dollar
sign respectively.  Expensive confusion results when a UK user receives a
document from a USA location (or vice-versa), since dollar figures now appear
in pounds, and cents magically become dollars.  The Germans avoid the problem
by using both characters for totally different (non-currency) symbols.
%
cursor:  n. An indicator, often a flashing underscore or rectangle, on a
display screen which shows where the next operation will take place (for
example, where typed characters will appear).  Invented by IBM researcher
John Lentz, circa 1954.  [A recent advance in "graphical user interfaces" is
to allow two (or more) cursors on the screen, thus to confuse the user more
rapidly and effectively.]
%
customer:  n. Any individual not currently employed by IBM.
%
customer ship:  n. A delivery of a product to a paying customer.  As in "This
product has remained faultless through 5,000 customer ships!" See also FCS.
%
cut:  v. To write (record) data onto a tape or disk drive.  Almost certainly
derives from the similar use of the word in the audio recording industry,
which in turn derives from the days when grooves were cut into wax phonograph
cylinders.  Tends to imply a relatively permanent recording, as in "Let's cut
the distribution diskette".  Also used to mean "write" more generally, as in
"Please ask accounting to cut a cheque for this invoice".  Also cut sand, to
burn sand.
%
cycles:  1.n. Instruction execution capacity.  An instruction cycle is (or
may be - the term is loosely applied) the time required to execute a single
instruction or part of an instruction in a computer.  Thus, if a program
requires the execution of a large number of instructions, then it is said to
consume many cycles.  "Cycles", therefore, is a term for one of the resources
that have to be worried about when designing a computer system.  "If we run
the formatter and the laser at the same time, we'll run out of cycles".  This
"technical" term is used to imply that one knows a little about computer
hardware.  See also MIPS, resource.  2.n. Of a person time.  From the
previous sense, as in "do it when you have some spare cycles".
%
dash:  n. Documentation level.  IBM documents bear a number comprising three
groups of characters, separated by dashes.  The final group is one or more
digits that indicate the revision level (when ordering a document, you do not
normally specify the final group - IBM will send the latest available).  A
dash-0 is an original (first version) document.  "To be at the latest dash"
means to have an up-to-date document.  Sometimes also used for software "We
run the latest dash of VM/SP".
%
data jail:  1.n. A database that is carefully being fed with information, but
whose owner is not sure that the information in it can be extracted when it
is needed.  From Fishkill "We're operating a data jail here".  2.n. A
mainframe.  (When used by a PC programmer.)
%
de-concur:  v. To formally remove one's approval or agreement to a project,
having previously approved it.  This ploy is most effective when used without
warning and less than a week before Announce, and will then usually be
devastating.  A favourite weapon of Legal departments.  See concur, concern,
issue, non-concur.
%
de-smut:  v. To correct errors in a SCRIPT file.  The name comes from the
name of the file in which Script stores error messages, DSMUTMSG.  "Looks
like you still have to de-smut some of those errors".  See also script.
%
debug:  v. To hunt down and remove some of the bugs in a piece of software or
hardware.
%
debugger:  n. A program or suite of programs whose function is to aid the
process of debugging.
%
decision support system:  1.n. A computer program claimed to help those with
power to make decisions.  2.n. Any computer system used to justify something
to higher management that could not be justified in any other way.  The
favoured technique for this usually involves getting the program to answer a
question different from the one that ought to have been answered.  Invariably
a MIP-eater.
%
deck:  n. A data file, usually in Fixed-80 format (every line of the file is
80 characters long).  As in "text deck" or "request deck".  This term dates
back to the days when all files were punched on 80-column cards for which the
collective noun was, of course, "decks".  This is still the correct term to
use when the file is a spool file present in the reader or punch of a virtual
machine (VM).
%
decommit:  v. To slip one's schedule for an indefinite period of time.  A
grave dishonour for project management.
%
deep staff:  n. Senior staff who has been out of active field or development
work for at least five years.  An expert in IBM politics and the art of
non-concurrence.
%
default:  1.n. A value that will be assumed for an object (such as a
parameter or argument to a program) if not explicitly specified.  As in
"What's the default for the paper size?" 2. adj.  Assumed if not explicitly
specified.  As in "What's the default paper size?"
%
delta:  1.n. A list of changes (e.g., the differences between two programs).
"Make me a delta on that proposal".  See also diff.  2.n. A wedge-shaped gap.
Especially one between two lines on a graph or chart, as when one line
represents the target and the other achievement-to-date.  See also jaws
chart.  3. v. To arrive at a result from some known base, particularly by
applying a percentage increase to all data.  As in "We'll just delta off last
year's plan".
%
demo:  1.n. A demonstration.  A demonstration is the exhibition of
non-functioning or unfinished hardware or software to senior management or
visiting VIPs.  Provides the ideal conditions for awakening dormant and
unsuspected bugs.  2. v. To demonstrate.  As in "We demoed the system
structure", or "When are you demoing today?"
%
demonstration application program:  n. A game.
%
depeditate:  v. To cut off at the feet.  Used especially in the context of
electronic formatting and typesetting when the descenders of lowercase
letters are cut off by a rule (line) or on reaching the end of a column or
page.
%
dependency:  n. A minor exposure.
%
design:  n. The preliminary sequence of events leading to the manufacture and
delivery of a finished product.  This may be a) An educated guess; or b)
[more commonly] An uneducated guess.
%
desk MIPS:  n. Processing power that is provided by physically small
(desk-top or desk-side) computers.  See also water MIPS, MIPS.
%
desk dump:  v. To clear all the paper on a desk into a drawer at night to
meet local "clean desk" policies.  The drawer then becomes a LIFO stack, as
most of the paper is never retrieved until archived in a waste bin.  See also
core dump, dump.
%
deskcheck:  v. To run a computer program through a "One Instruction Per
Second" [at best] human processor, in order to check or test it by thought
experiment.  See also inspection, MIPS.
%
diagnostic:  n. A program written to test other programs or (more usually)
the hardware of a system.  It is intended to be used, when a failure occurs,
to identify the failing unit or sub-assembly.  It often seems that
diagnostics are the only pieces of code that will run cleanly when the
hardware starts to fail, as the diagnostics were of course written to test
the expected modes of failure.
%
dialogue:  1.n. A pompous alternative to "conversation" or "chat".  "Let's
have a dialogue".  2. v. To talk to.  As in "Why don't you call Steve and
dialogue with him about that project?"
%
diff:  v. To make a list of changes.  Refers to the widely used program DIFF
that attempts to show the differences between two program or data files.
"Please diff those two proposals for me".  See also delta, bridge.
%
dinner for two:  n. A small award to recognise an employee's contribution to
a project or department.  The amount of the award is small enough that a
first-line manager can bestow the award with only one, or no, higher level
approval, but yet is sufficient to pay for a good dinner for the employee and
a guest.
%
dinosaur:  1.n. A person or location that clings to old software packages
long after everyone else has moved to later and better designs.  Usually only
a cataclysm (in the form of a major new release of operating system software)
will encourage a change in the lifestyle of a dinosaur.  2.n. A major problem
or bug.  Usage "OK,...  we'll build a system and bring it up second-level to
get the dinosaurs out.  Then we can start the detailed debugging".
%
disclaimer:  n. A list of conditions or warnings that modify the material
just about to be presented at a meeting.  A boiler plate blanket statement
that disassociates and relieves a presenter of any responsibility from
conclusions that his audience may have reached as a result of his statements,
regardless of whether the conclusions were intended or not.  Commonly used in
hardware or software proposals and performance presentations.  See also
caveat.
%
disconnected, disc'ed:  1. adj.  Of a VM Virtual Machine not logically
connected to a terminal, and therefore running without human intervention.
The VM operating system supports two "inactive" states loggedoff (not using
the system at all) and disconnected (suspended).  When disconnected, a userid
maintains all its state and activities, but has no "real" user terminal
connected to the virtual machine.  Most service machines run disconnected.
2. adj.  Of a user not using a network or computer.  Also discoed, as in "I
tried to see if she wanted to vend [buy coffee from a machine] with us, but
she's discoed".  3. adj.  Of a person paying little attention to the outside
physical world, due to distraction, great ideas, or lack of sleep.  Such a
person is usually reconnected by a loud yell from a suitably high
(hierarchical) level, or by a stiff dose of caffeine.  4. adj.  Having little
interest in a particular topic.  "Since I started to use VM, I've been pretty
much disconnected from TSO".
%
disk:  n. A magnetic or optical storage mechanism in the form of a rotating
disk.  Information is recorded on the disk in the form of numerous concentric
"tracks" or as a single spiral track.  The term is also used for logical
simulations of disks that are in fact held on larger disks, or in main
storage, or on magnetic tapes or cartridges.  See also file, floppy disk,
minidisk, round and brown, Winchester disk.
%
disk farm:  n. A large room (or rooms) filled with magnetic storage machines.
Infrequently frequented by humans.
%
diskette:  n. A floppy disk.
%
distributed data processing:  1.n. (Official version) A methodology for
selling small CPUs for use at remote sites.  2.n. (Unofficial version,
pre-1986) A methodology for spreading competitors' minis and micros around
remote sites, as there was no 4311.  [But now there is the 9370.]
%
in a ditch:  adj.  Broken, non-functional.  As in "That program is on its
back in a ditch".  See down, crashed.
%
do it right first time:  n. A popular Quality slogan.  Potentially synonymous
with the slogan, "Let the user do the debugging".  Correctly deciding what to
do next is perhaps even more important.  See creationism.
%
document administrator:  n. Quote from a GML manual "One who is responsible
for defining markup conventions and procedures for an installation.  This
involves defining the actual vocabulary of tags to be used and also the
nature of the processing required for each".  [Need one say more?]
%
document of understanding:  1.n. (When signed by one party to an agreement.)
A memo that is used to present one party's view of an agreement in the best
possible light.  Usually shows little or no understanding of the problems of
the other party to the agreement.  See CYA.  2.n. (When signed by both
parties to an agreement.) A document (which is not a contract) drawn up
between two different departments or companies within IBM, often associated
with the transfer of a product or program from one group to another.  The
only mechanism whereby the owner of a piece of software can maintain any
formal control over it once another IBM group has a copy of it.  [Also known
as a letter of understanding or memo of understanding.]
%
documentation:  1.n. The several kilograms of mashed, pounded, bleached, and
pressed trees that accompany any modern, sophisticated product.  Happily,
documentation is sometimes now provided on-line (that is, available at a
computer terminal), and is, of course, always written before implementation.
2.n. Instructions translated from Swedish to Japanese by Danes for the profit
of English-speaking persons.
%
dog and pony show:  n. A presentation designed to [over-] impress.  Implies a
certain amount of cynicism and deception, and contempt for the audience.
%
dollarize:  v. To express intangible assets (such as programmer creativity)
in terms of U.S. dollars.  This allows even the most subtle of concepts to be
grasped by the materialistic.
%
done deal:  n. Something that has been done and is no longer open for
discussion; a fait accompli.
%
dotted to:  1. adj.  Having a managerial relationship or political link that
cannot be described by a hierarchical tree.  Refers to the (dashed) lines
shown on organisation charts.  This is often used for professionals (such as
lawyers and accountants) whose managers do not understand what they do, so
they are "dotted to" someone in Armonk.  An "abnormal but legitimate"
relationship.  2. adj.  Directly connected by hardware.  In electronics, a
Dot is often a wire-ORed or wire-ANDed gate the logical operation takes place
by two gate outputs being connected directly, and the final output depends on
which gate wins.
%
doubleword:  n. Eight bytes (an IBM System/370 Word is 4 bytes, or 32 bits).
A doubleword boundary is an address that is an exact multiple of eight.  Many
System/360 or System/370 instructions either require their operands to be
aligned on a DW boundary, or work much faster if the operands are so aligned.
See also fullword, halfword.
%
doughnut:  n. A ferrite core (actually a torus or ring about one or two
millimetres in diameter, hence this term) used in the Core memory of early
IBM computers.  Also donut.  Ferrite cores are still used in some IBM
computers, such as those used on space shuttles; in the commercial world
probably the last product using core memories that was announced was the
control unit for the 2305 drum (shipped in 1973).  See also core.
%
down:  adj.  Not working; the opposite of up.  Crashed.  The state of the
system or printer when you need one more listing and you are already late for
your plane.  See also bring up.
%
down-level:  1. adj.  Out-of-date.  Applied to a person who is not up to date
with some technical nuance, or to a piece of software that is not the latest
(current) version.  Derived from FE terminology applied to software.  See
also back-level.  2. v. To demote, to reduce in level.  Also re-level.
%
downtime:  n. The length of time that a system is unavailable to users
(down).  "How much downtime did we have last week?"
%
dramatic:  adj.  Uninteresting.  An adjective used to make an unexciting fact
sound worthy of attention, as in "A dramatic three percent increase in I/O
throughput".  See also exciting.
%
drink from a fire hose:  v. To be at the receiving end of a flood of
information, as when attending a major university for the first time.
Originally used in IBM to describe how it was for European visitors to the
Boulder lab as they tried to "get up to speed" on the Mass Storage System
during its development.  A group at Boulder was charged with teaching the
visitors how the system was designed and how it worked [markedly different,
I'm told].  This group spent "a memorable 18 months or so in 1972-74
designing microcode debugging classes one day ahead of the students".
%
drive:  1. v. To push a project along in spite of many objections and
obstacles.  "Sam, you will drive the water fountain replacement project to a
successful conclusion by next Tuesday, won't you?" 2.n. A mechanical system
for rotating some piece of a computer, as in "Disk Drive".  Also used to
refer to a complete disk assembly, as in "Place the diskette in the B Drive".
See also spindle.  3. v. To use or control, especially of a terminal or
program.  Usage "I'm not sure how to drive this debugger".
%
drive-in branch:  n. ISG HQ in Bethesda, Maryland.  Named for an incident in
1982 when a former IBM employee drove his car through the doors of the
building (which never was a branch office, in fact) and went on a shooting
spree that killed or injured a number of people.  Many of the fortifications
around the entrances of IBM buildings date from this incident.  [This usage
is unfortunately quite common, being used by those unaware of the details of
the incident.  It is considered to be in bad taste by those who lost friends
and colleagues.] See also Rusty Bucket.
%
driver:  1.n. A program that "drives" a bucket of test cases.  2.n. The main
processing loop of an interactive program.  3. n. A complete new level of a
system.  As in "The developers cut us a new VM driver yesterday".
%
driving a brown desk:  adj.  Having achieved the technical rank of Advisory
Engineer (or Programmer).  This derives from the practice in some locations
of giving tacky metal desks to the more junior employees, and reserving real
(wooden, or wood veneered) desks for those who have been around for some
time.
%
drop-dead date:  n. A deadline by which certain events must have occurred if
irretrievable loss of honour or revenue to IBM (or a customer) is to be
avoided.  Should the events not occur, irretrievable loss of honour and
revenue to the responsible marketing representative is likely; and the phrase
may take on literal overtones.
%
drum card:  n. A card, wrapped around a cylinder or drum within the mechanism
of an IBM 026 or 029 card punch, that controlled some of the features of the
punch, such as tabbing, automatic duplication, numeric shift, etc.  A little
drum card wizardry could often save hours or days of data or program entry
time.
%
dual-path:  1. v. To provide alternative paths through program code in order
to accommodate different environments.  "Since the CP response is different
in VM/SP and VM/XA, we'll have to dual-path that Exec".  See also
special-case.  2. v. To make a peripheral device available through more than
one channel.  This can improve performance, and, on multi-processor systems,
allows the device to be available even if one processor is off-line.
%
dual ladder:  n. The principle that one can rise in the company at equal
levels in either a managerial or a technical job.  Once impossible outside
the USA (most countries did not even maintain the practice of having
different titles for technical and managerial personnel) but more fashionable
since the late 1980s.
%
dump:  n. A collection of all available information about a problem, usually
deposited on the slowest printing device available.  Originally a complete
printed representation of all the storage in a computer, this was a
manageable quantity of information when a 100 Kilobyte machine was a big one.
Now that machines are so much larger, dumps contain a vast amount of
irrelevant information - yet some people still use dumps for debugging
problems.  (Equivalent to cracking an eggshell with a steamroller.) The
"Garbage Out" part of "Garbage In, Garbage Out".  See also core dump.
%
earth:  n. The safety cable in a domestic or commercial power supply.  This
is the term used by non-USA English speakers instead of "ground", possibly
reflecting the more rounded world view of such people.
%
earthquake:  n. A real-life shock test for computer equipment.  Contrary to
popular belief, recent earthquakes near California plants were not initiated
by IBM as part of the Quality testing program.
%
ease-of-use:  1.n. The attribute of being easy to use.  An ill-defined but
positive quality achieved only by products of the speaker's company or
laboratory.  2.n. A quality claimed for all programming languages, to
demonstrate superiority over machine languages or lower level languages.  OS
JCL is a fine counterexample to this claim.
%
easter egging:  n. Replacing an unrelated part in the hope that a malfunction
will go away.  The term derives from the USA and European Easter-time
practice of hiding coloured eggs, chocolates, and other goodies around the
house, the garden, or the town square.  Children are invited in and usually
then engage in a hurried scamper through the territory to collect goodies and
win various prizes that may be awarded.  The implication in the jargon usage
is that the engineer did a similar search through his machine looking for the
part that would fix the problem.  This is the only IBM-approved game of
chance, except that Easter Egging is forbidden in the 308X Processor Complex.
%
eat one's lunch:  v. To use up personal time.  Used after attempting to fix a
system, usually a broken one, for such an intensive and extended period of
time that one emerges from the effort to find that one's personal time has
mysteriously disappeared.  "That 3380 string was down all day with a power
bug that ate my lunch".
%
edict:  v. To decree, to issue an edict.  "The use of Structured Programming
was edicted by Corporate".
%
elastic:  adj.  Able to stretch.  This is used to refer to a schedule that is
subject to frequent stretching.  Unlike true elastic, such schedules rarely
contract (shorten).
%
emotional issue:  n. A real problem (as seen by one person) when not seen as
a problem by another person.  Used when the second person is insensitive or
(more commonly) has no taste.
%
end user:  n. A person at the end of the chain of hardware, systems, and
interfaces.  A (possibly hypothetical) person who is expected to represent
the biggest group of users of computer equipment in the future.  When usage
of the term is such that it implies that the speaker is superior to such an
end-user, the speaker has identified himself or herself as at best
insensitive and at worst, arrogant.  See also naive.
%
engine:  n. A small processor such as the 8100, or a microprocessor (when
used as the central processor in some device).  "Our new terminal cluster
controller uses the latest engine".
%
engineering change:  n. See EC.
%
enhancement:  n. A fix for a problem that has been reported too often to be
ignored.  See feature.
%
entry-level:  adj.  Simple enough for a naive user to start with.  Sadly,
many entry-level computer systems are just toys - they do not have the
capabilities necessary to do real work.
%
entry system:  n. A system that is easy to start using, either because it is
inexpensive (cheap) or because it is simple to use (entry-level).  Something
to do with frontdoor bells?
%
escalate:  v. To take a matter to higher (managerial) authority.  Very
effective as a threat.
%
evolution:  n. The process of implementing a large system by incremental and
coherent improvements to a simple system.  No other process has ever been
known to work.  See creationism, creeping featurism.
%
excellent:  adj.  best-of-breed.
%
exciting:  adj.  Having the lowest interest ranking for speeches and papers
delivered at internal meetings.  The complete sequence is exciting,
interesting, dramatic, mind-boggling, and Registered IBM Confidential.  See
also dramatic.
%
exec:  n. A macro whose output is a sequence of commands for the
Conversational Monitor System (CMS).  The term is derived from the name of
the original interpreter, and the filetype that distinguished these macros.
The meaning is often extended to include any macro written in the EXEC, EXEC
2, or REXX languages, regardless of the destination of the generated commands
(GDDM, SQL, etc.). The term is reported to have spread to the PC-DOS
environment, where it designates the PC-DOS equivalent of CMS Execs -
otherwise known as BAT (batch) files.
%
execute:  v. A commonly used word more or less meaning "to run" (a program)
or "to process".  The term is now avoided in IBM customer publications since
it makes readers in many countries nervous.
%
exempt:  adj.  Of a Domestic employee's job level exempt from certain labour
laws; no longer eligible for payment for work carried out after standard
hours.  Implies (but does not necessarily mean) that the employee has reached
"professional" status.
%
exercise:  1. v. To test by running a collection of tasks, often by running a
test bucket.  This gives a new or overhauled machine a chance to become more
physically fit before undergoing a rigorous acceptance test.  "We are going
to exercise the machine".  See also stress.  2.n. A play, or sham, project.
%
exerciser:  n. A program written to intensively exercise a portion of a
machine.  The hope is that an operation that occasionally fails can be forced
to fail more often, and frequently enough to allow the CE to find and correct
the fault.  See also stress.
%
expectation management:  n. A management technique whereby the target
employees are persuaded to feel truly grateful for what they are about to
receive.  An essential prelude to the assignment of "career developing"
tasks, or to the removal of services.  See also job rotation.
%
expert:  n. One who has some knowledge of a topic that therefore qualifies
him or her for an urgent but undesirable task.  "I hear you're our JCL
expert" - "Well, I did look at some JCL one afternoon a few years ago..". -
"So you are the expert then!".  See also guru.
%
expire:  v. To pass, irrepealably.  "That issue has expired its deadline for
solutioning".
%
exposed:  adj.  Almost certain to be omitted.  This is used to describe part
(or all) or a project that must for political reasons be described as
in-plan, yet is unlikely to actually be produced.  "The third line item is
in-plan, exposed".
%
exposure:  1.n. Some aspect of a project that looks as though it may become a
problem.  "That's a big exposure".  See also dependency.  2.n. Danger, risk.
A necessary euphemism, since the words are not otherwise found in the IBM
vocabulary.  3. n. Visibility to upper management or external agencies.
"You'll get good exposure in this assignment".  As all mountain climbers
know, there is always the risk of over-exposure unless one takes proper
precautions.
%
exterior wet conditions:  n. Rain.  The term used by IBM Canada's security
department to excuse evacuation of a headquarters building during a fire
drill.
%
external audit:  n. Examination of the current state and risks of a project
by an outside group, followed by a report of its findings.  The report
usually tells upper management exactly what they were afraid that they would
discover if they were to pull their heads out of the sand.  See bad
information.
%
externalize:  v. To document or publish.  Usually found in the negative, as
in "We have decided not to externalize the format of the CICS System
Definition File".
%
face down, nine to the throat:  adj.  Computers that used cards for input
data (and pre-computer tabulating equipment) required that any deck of cards
be stacked in a particular way to process correctly.  Almost every IBM
machine that used cards carried a label in the card feed area indicating how
to place the deck in the feed hopper of that machine; the most common was
face (printed side) down, with the 9-edge forward, towards the throat where
cards are swallowed by the machine; this phrase dates from the 1952-1964 era.
The later face down, 9-edge forward, and the alternative face up, 12-edge
first were very common, and may still exist on working card machinery.
Engineers who were unusually proficient in, or (more commonly) obsessed with,
computers and their technology were said to eat, sleep, and breathe computers
until ultimately they would be "buried face down, nine to the throat" - an
expression of mild esteem.  See also column binary.
%
face time:  n. Time to confront another person face-to-face.  "I think it's
face time on this one".
%
facility:  1.n. Being facile.  Like most people, IBMers do not recognise this
meaning, but often demonstrate it.  2.n. The ability to make something easier
(or even possible); incorrectly derived from the verb "to facilitate".  Used
in the titles of many IBM service functions and products which would
otherwise not be polysyllabic enough to make their designers feel important.
See also polysyllabic, system.  3. n. A program or software package whose
function is (by the definition of its authors) useful.  "Facility" is usually
a misnomer, however, as the programs that are accredited this grand
description are often exceedingly complicated and difficult to use.
%
failsoft:  adj.  Of a system or network designed so that the failure of one
part of the system will not be catastrophic; some or all of the requirements
of some or all of the users will continue to be met.
%
fall on one's sword:  v. To voluntarily decommit a plan, knowing that this
action will invoke extreme displeasure.  Falling on one's sword was the
honourable means for a Roman to commit suicide.  "I knew we couldn't make the
dates so I went to the boss and fell on my sword".
%
fall over:  v. Synonymous with ABEND, crash.  As in "One of the 2305s fell
over last night and took CP with it".
%
fallback plan:  n. A plan to fall back upon should the first plan be rejected
by higher management.  This is often the plan preferred by the development
manager - he can count on his management turning down the first plan (so
demonstrating their power) but can be reasonably confident that the second
one he proposes will be accepted.  This strategy, of course, becomes a
selffulfilling prophesy; since the first plan is not the preferred plan, it
is often not properly thought out or presented - and is hence guaranteed to
be rejected.
%
family dinner:  n. An evening meal paid for by IBM, usually before Christmas,
for a department or group of departments.  The term derives from the ancient
concept of IBM being one big happy family of employees.  This is supposedly
an event to recognise the effort put in during the year, and can therefore be
relied upon to introduce colleagues from work whom one has never met and did
not know existed.
%
fast back end:  n. That part of a product development cycle that is supposed
to take far less time than usual in order to make up for the schedule slips
of the earlier parts.  "We'll have to put in a fast back end in order to make
FCS on time".  [That is, drop some of the testing.]
%
fast track:  n. A career path for selected men and women who appear to
conform to the management ideal.  The career path is designed to enhance
their abilities and loyalty, traditionally by rapid promotion and by
protecting them from the more disastrous errors that they might commit.
%
fastpath:  1. v. To enhance the performance of a program in certain cases by
reducing the amount of code executed when a given condition arises,
especially when the condition is common, or where the existing performance of
the program doesn't meet users' expectations.  "We will have to fastpath the
case where the file isn't open yet".  See also special-case.  2. v. To access
some data directly, rather than, for instance, following an otherwise
tree-structured (hierarchical) path.  For example, instead of selecting
choices "1", "3", "4", "B" in consecutive menus, you might be able to go to
the same panel by typing "134B".  This can be much faster, especially over
slow connections, because only the final menu will be displayed.  Of course,
strings such as "134B" were formerly spelled differently (for instance,
"COPY") and were known as commands.  3. n. The nickname used to directly
access some panel in a treestructured menu.  As in "what's the best fastpath
to get to PCPRICES?"
%
fat, dumb and happy:  adj.  Complacent.  Typically used of a project's
management who think that their project is competitive when it is not.  [Not
exclusively an IBM term.]
%
fatal:  adj.  Very serious.  When used to describe a problem, this indicates
that recovery from the problem has not been possible, as in "FATAL I/O
ERROR".  Always presented in all upper case, as only t'owd man was confident
enough to use such a word in a Data Processing environment.  ["T'owd man" -
An Ancient (from the Derbyshire mining term).]
%
fatherhood:  n. Something that is good, but not necessarily true.  See
motherhood.
%
feature:  1.n. A piece of a product (software or hardware).  2.n. A bug for
which no fix is going to be made available.  3. n. A correction to a
publication.  4. n. A mandatory "option" on a piece of hardware.  As in "Of
course, if you want to run any software on this machine, you must order the
optional Decimal Feature".  See also creeping featurism, enhancement.
%
feature shock:  n. A user's confusion when confronted with a package that has
too many features and poor introductory material.  Originally a pun on Alvin
Toffler's title Future Shock.
%
feeb:  v. To perform some act in a feeble (or awkward) manner.  For example
"He really feebed that piece of coding".
%
feecher, feechur:  n. An unforeseen, arbitrary, or capricious attribute,
which, once documented, is spelled "feature ".
%
fence:  1.n. Some special sequence of characters (such as hexadecimal "FF")
used to delimit other data.  Usage "You should put a fence at the end of the
parameter list".  2. v. To protect storage so that it cannot be stolen by
another user while you are not actually using it.  An excellent mechanism for
justifying a storage upgrade.  See also fence out.  3. v. To protect people
from being "poached" by other departments.  "My Adtech headcount is fenced
this year".
%
fence out:  v. To electronically disconnect an element from the operating
configuration.  In the 308X series, Fencing Out is done by fence registers
that are set and unset by the Processor Controller.  This concept was devised
by the original 308X RAS Engineering Department, and in doing so they
discovered the aeroplane rule (see above).  See also box, granularity.
%
ference error:  (fear-ence error) n. An indexing error occurring when the IBM
System 38 encounters a null or invalid index or subscript.  This derives from
an error in a message handling routine, that truncated the first two
characters of the message - it should have read "Reference Error".  However,
"Ference Error" conveys just as much information.
%
field:  1.n. The IBM marketplace - where the profits come from.  Anywhere
outside the Development group.  2.n. (When used at a headquarters location.)
The development laboratories.
%
file:  1.n. A collection of records held in a filing system on a disk or
other storage device.  2.n. A magnetic disk storage device, usually a
Winchester.  "We're designing hard files for PCs".
%
file farm:  n. A disk farm.
%
finding:  n. A security exposure, discovered during a Security audit.  In
theory, a finding could be either good or bad, but there have been no reports
of a good finding.
%
finger check:  n. A typing error on a computer terminal.  Usage "I took a
finger check while entering that command".  Derived from the usage of check.
See also brain check.
%
finis:  (fin-iss) n. To close a file, under the CMS operating system.  This
[Latin] command name was chosen by a Frenchman who worked on the CMS file
system in the 1960s.  Often the incantation "FINIS * * *" (close all files)
is suggested as a panacea for CMS applications developers.
%
firefighter:  n. A person or group of people called in to put out a forest
fire.  A good firefighter is the highest form of programmer life, but all too
often firefighters are totally unfamiliar with the fire being fought.
Firefighters are famous for their interim patches or fixes.  These patches,
once implemented, become permanent and the tinder to spark off later Forest
Fires.  It is often said that firefighters are "called too late to even water
the hot ashes".
%
first-line manager:  n. The lowest level of line management.  A first-line
manager has only "employees" (as opposed to managers) reporting to him or
her.  A second-line manager will hold the cards of (employ) at least one
first-line manager.  The term can also be used in a relative sense; when
employees report directly to upper levels of management then one person's
third-line manager can be another's fifth-line.
%
fix:  n. A correction for a software problem.  "You need the following three
fixes to correct the file system bug".  Software equivalent of engineering
change.
%
fix it in pubs:  v. To change the product publications.  Unfortunately
nothing to do with the ancient art of Ale sampling, but is instead a
favourite way to correct any problem found in the six months before FCS.  See
feature, pubs.
%
fixed disk:  n. A disk, usually a hard disk, packaged with its electronics
and which cannot easily be removed from the machine in which it is installed.
%
fixed head:  n. A Read/Write head which is fixed in position relative to the
surface of a disk, rather than being moveable across some or all of the disk.
Data that are on the disk surface under a fixed head can be accessed more
rapidly than those under the more common moveable heads; the fixed head area
of a disk is therefore often used for paging, database storage, etc.
%
flash:  v. To copy by xerography.  See also ibmox.
%
flatten:  v. To bring under control, to eliminate, or to make less
conspicuous.  "Gee, we've got bad problems with that new software from
Yorktown.  Shall we bring a bunch of them up to flatten the problem?" (The
implication being that any problem can be trampled into the dust by the
application of hordes of programmers.) The origin of this term in fact comes
from the mathematical sense of flattening a curve (or worse, a vertical line)
showing problem discoveries, APARs, et al.  Usage "We'll flatten that problem
when the Umbrella PTF gets out there".
%
flavour, flavor:  n. A variety or version of a program or piece of hardware.
"This system comes in two flavours SP and XA".  An analogy with ice-cream
varieties.  See vanilla, chocolate, mocha.
%
fletching:  n. See snow, angel dust.
%
flextime, flexitime:  n. A scheme allowing flexible working hours.  These
schemes let people vary their start and end times from day to day, around a
fixed core time.  With some schemes one can accumulate excess time worked and
use it for extra leave.
%
flipchart:  n. A large piece of paper used for drawing charts as a
presentation aid.  Often faintly marked with squares which are of length
1/7920 part of a furlong on a side (once known as an "inch").  These 25.4mm
squares help the presenter draw straight lines.  Once especially favoured for
formal presentations at Corporate HQ, but nowadays almost totally superseded
by foils, slides, PCs running fancy programs, and projection displays.
%
floor sort:  n. A spilt box of computer cards.  A standard box held
approximately 2000 cards, which could be shuffled by the simple and effective
technique of depositing them in a heap upon the floor.  If the cards did not
have a sequence of numbers to identify their order they had to be re-sorted
by hand.
%
floor system:  n. The operating system used by the majority of people on a
machine (as opposed to a test or private system).  See spin system.
%
floppy disk:  n. A flexible magnetic storage disk, now more often called a
diskette.  Floppies were originally eight inches in diameter, and were first
used, in the early 1970s, for loading the initial program into control units
and mainframe computers.  See IPL, Minnow.
%
focal point:  n. A person who has been assigned responsibility for
coordinating an effort or supporting a large project (such as the development
of microcode for an entire system).  Warning if you are at a focal point, you
may get burned.
%
focus:  n. Critical scrutiny with a view to swift corrective action.  As in
"There will be focus on Quality at yearend".
%
foil:  n. Viewgraph, transparency, viewfoil - a thin sheet or leaf of
transparent plastic material used for "overhead" projection of illustrations
(visual aids).  Only the term "Foil" is widely used in IBM.  It is the most
popular of the three presentation media (slides, foils, and flipcharts)
except at Corporate HQ, where even in the 1980s flipcharts are favoured.  In
Poughkeepsie, social status is gained by owning one of the new, very compact,
and very expensive foil projectors that make it easier to hold meetings
almost anywhere and at any time.  The origins of this word have been obscured
by the use of lower case.  The original usage was "FOIL" which, of course,
was an acronym.  Further research has discovered that the acronym originally
stood for "Foil Over Incandescent Light".  This therefore seems to be IBM's
first attempt at a recursive language.
%
fold:  v. To change minuscules (lowercase alphabetical letters) to majuscules
(uppercase alphabetical letters).  Also "translate to upper case".  Only a
very few pieces of software do this correctly for languages other than
English, or even claim to.
%
follow-on:  n. A new release or version of a product, sufficiently different
to merit a new product number but including all the bugs and problems of the
previous product architecture.  (This is the usual result of being compatible
with previous releases.)
%
food chain:  n. The (hierarchical) line of management.  An indirect reference
to the military term "chain of command", and to the zoological term.  As in
"He is too low in the food chain to really matter".  See also line
management, lion food, nonlinear.
%
footprint:  1.n. The floor or desk space taken up by some piece of computer
equipment, such as a terminal or processor.  As in "Our box has a smaller
footprint than that of xyz".  See also visual footprint, toeprint.  2.n. The
audit trail left by a program so that a recovery program or programmer can
determine the areas of storage that the first program stepped upon.
%
footware:  n. Footwear.  A list of tennis rules published by the Yorktown IBM
Club reminds us that "Proper footware is required (tennis shoes/sneakers)".
%
forecast:  n. A prophecy of the number of sales of a product as a function of
price at which it will be offered.  This is typically made by people who have
never used or sold such products and based upon [wild] guesses by some people
who have.  The forecast has no relationship to either the quality of the
product or the value as it might be perceived by the potential customer,
since the forecasters are not the people allowed to discuss the product with
the customer at this stage.  Thus a forecast is either strikingly inaccurate
for a low price and large number of sales, or a painfully selffulfilling
prophecy if it is high priced and low volume.
%
forest fire:  n. Something bad that happens, such as a manufacturing problem
or a machine crash, that receives an undue amount of attention from
high-level management.  This causes productive work to cease as all available
personnel become firefighters.
%
forum:  n. A file containing discussions about a given topic on a conference
disk.  (Plural usually fora.) Usually a mix of wild applause, bug reports,
suggestions, questions by those who did not read the documentation, questions
by those who did (but did not find the information wanted), and completely
out-oftopic appends.  Most forums are of considerable value, and form perhaps
the most significant method of technical communication within IBM.  Others,
being cultural rather than technical, are no less valuable but are less
obviously productive - one of the most famous is (well, was, since it has
been removed by the editor) the BYTE8406 FORUM on the IBMPC conference.  This
spawned from a hint about a yet unannounced PC in the June 1984 issue of Byte
magazine, and degenerated into a long compilation of stories about old
hardware.  Browsing forums has become a corporation-wide occupation, and is
one of the favourite sports of tube-jockeys.  See also append, conferencing
facility, BYTE8406 syndrome.
%
forumish:  adj.  Of a file behaving like a forum.  That is, new data are
added at (appended to) the end of the file.
%
freezer:  n. Somewhere where ideas or idealists can safely be stored, almost
indefinitely.  Also a place where task force results are stored (e.g., a
filing cabinet to which no one has the key).
%
fridge:  n. A 3274 Terminal Controller.  So called because it has the same
shape, dimensions, weight, and noise profile as a small domestic
refrigerator.
%
friendly:  adj.  Local.  As in "Before ordering that whizzbang new PC
software, check it out with your friendly legal advisor".  In no way
connected with user-friendly.
%
frozen:  1. adj.  No longer open to ideas or changes.  Applied to a project
that has cooled sufficiently to let someone in power successfully quench any
red-hot or innovative idea which might be relevant to the project.  Also
applied to a program that will not have any further fixes or enhancements.
See also cast in concrete, functionally stabilized, terminate.  2. adj.
Affected by a highlevel edict to "freeze headcount" (stop hiring new
employees) in a particular way.  For example "Westchester is frozen".
%
full court press:  n. Instruction to an entire marketing team to press sales
at an account at all levels possible.  From the basketball term.
%
fullword:  n. Four bytes (an IBM System/370 Word is 4 bytes, or 32 bits).
Many System/370 instructions run faster when their storage operands are
"aligned" on a fullword boundary, that is, they start on an address which is
an exact multiple of four.  See also halfword, doubleword.
%
fun and games:  n. Anything that does not directly result in short term
revenue to the corporation.
%
function:  n. An undefined measure of the value of a program or machine, in
the sense of describing what it is able to achieve.  Usage "How much added
function will we get with that line item?" The word may be contorted further
"How much functionality does that have?"
%
functionality:  n. Capability, function.
%
functionally stabilized:  adj.  Dead.  Said of a product that will receive no
further enhancements.  See also frozen, sunset.
%
fundamental:  adj.  Most important and basic.  The noun qualified is to be
taken as gospel and is not be questioned.  For example "The fundamental
requirement is ease of use".
%
funded:  adj.  Of a project formally assigned a budget, possibly of funny
money.  Better than a hobby ; about 4 on a scale of 1 to 10, where 10 is
strategic.
%
funny money:  1.n. U.S. dollars used or quoted in an internal budget or plan.
These have a hypothetical, play-money aura - felt especially by those
employees to whom the dollar is not the native unit of currency, or when the
sums involved are very large.  See also blue money.  2.n. Test paper pieces
used by engineers to test automatic bank tellers and cash issuing terminals.
To test the machines properly these often need to be remarkably similar to
the real thing, and hence merit appropriate security precautions.
%
gap:  n. The difference between "What The Customers Want" and "What We Can
Produce".  This term is used by the planning community to indicate blind
faith in the ability of the Development Divisions to come up with a product
that will rectify planners' droop and keep the revenue growth going.  Note
that it is no part of the Planners' responsibilities to plan whatever product
might be required, or be produced, to bridge the Gap.
%
gap product:  n. A product conjured out of murky air in the hour before the
Fall Plan is due, to fill a gap in revenue projections [forecasts].  Often
the gap product will be designed to use surplus parts from other products
which are in a state of decline.  See also planners' droop.
%
general:  n. A meeting between a manager and one of his or her employees for
an unfocused discussion, usually of a personnel rather than technical nature.
%
gerbil tubes:  n. The walkways connecting various buildings at the Raleigh
(Research Triangle Park) site.  Known for their windowpanes, which can pop
out when there is a large inside/outside temperature differential.
%
get in bed with:  v. To work closely with.  Usage "You will just have to get
in bed with those people in Raleigh".
%
get your ducks in a row:  v. To get a number of people - usually at a lower
level - to provide formal approval of a decision that has already been taken.
"OK, let's do it.  When can you get your ducks in a row?" Also, get your
ducks in order, as in "When you escalate, be sure you have your ducks in
order, because that's the caboose that pushes the train".
%
glasnost:  n. Openness to customer problems.  By analogy with the Russian
word used to designate a "liberal" policy of discussion.  When an IBMer
practices glasnost, the customer may get more than the Official IBM Answer.
%
glass:  1.n. Silicon chips (integrated circuits).  Usage "We can't get the
upleveled hardware until the new glass gets through Fishkill".  The reference
is from the observation that both integrated circuits and glass are made from
silicon (sand).  Originally the term Glass referred to the photographic
masters for cards or chip transistors.  The image on the glass was projected
photographically onto photoresist on the base surface.  The 3195 had several
"glass expediters" during development and production.  See iron.  2.n. The
cathode ray tube in a display terminal.  "It's the way it looks on the glass
that matters".  Also used in the sense of real estate needed for display.
"That's a neat button design, but how much glass will it use?"
%
glass house:  n. A large data processing centre or corporate information
service.  As in "We haven't been able to find one architecture that can run
from the desktop to large glass houses".
%
glass navel:  n. The artificial part allegedly added to some people when they
attend certain types of internal or external education courses that are
perceived by others as a form of brain-washing.  The connotation is that the
recipient of the glass navel needs it in order to see his or her new view of
the world.
%
glass teletype:  n. Before the 3101 ASCII terminal was announced any non-IBM
"dumb" CRT.  After the 3101 was announced the 3101.
%
glitch:  n. An electrical pulse that is shorter than most and, more
importantly, occurs where it shouldn't.  By definition (see pulse) it cannot
be observed, and it is therefore used as the perfect scapegoat to describe
all hardware failures in electronic equipment.  It is claimed [untruthfully]
that all glitches are caused by lightning strikes (or cosmic rays), and
therefore such problems are unavoidable.  The meaning also encompasses
software problems, to denote a weird program behaviour that happens once and
cannot be replicated.  In this case software people prefer to blame a
hardware glitch.
%
glove compartment:  n. The small space under the wrist rest of 3278/9
keyboards where a leaflet to aid troubleshooting (the Problem Determination
Guide) is kept.  The first place to check for a list of passwords.
%
go away:  v. To vanish inexplicably.  Normally used in a kind of prayer or
litany "With a bit of luck, that problem will go away when we install Release
XXX".
%
go faster stripes:  n. Frills added to a hardware product to make it appear
to run better.  IBM hardware does not need these, of course.  See also bells
and whistles.
%
go to the mat:  v. To fight it out by going to higher authority.  From the
wrestling term.  See escalate.  gotta minute?  interjection.  "Please come to
my office right now".  [Some snooper found a demonstration application
program on one of your disks.]
%
gold-coaster:  n. Someone who is "coasting" until retirement.  This term is
especially applied to such a person who acquires or applies for a transfer to
Boca Raton or Tampa, in Florida.  The local tourist agencies' name for that
part of Florida is the "Gold Coast" [hence the nice double meaning].  See
also IPR, ROJ.
%
gold card:  n. A logic card or module claimed, by its engineers, to be
perfect.  It can be used to debug card test programs, or for swapping with
the cards in defective machines when no-one has a clue what is wrong.  See
also red line card.
%
golden diskette:  n. The release version of a PC software package.  Also
golden code.  Usage "Of course, we never get to see the specs until the
golden diskette is ready to ship".  The Personal Computer variety of to-PID
version.
%
golden handshake:  n. A signal (originally in the form of a handshake, but
now sometimes simply music played over the public address system) from a
manager to his or her employees, made on the day before a major public
holiday (such as Thanksgiving, in the USA).  It signifies "have a good
holiday" and implies "you are now free to leave early today, if you wish".
This phenomenon seems to be USA only, and (judging by recent memos) has been
over-used in some places.  A reader tells of a colleague who, before every
holiday, used to trace his hand on paper, cut out the tracing, tape it to a
ruler, and then thrust it out of his office door every time his manager went
by.  Others tell of times when their manager didn't know of this convention,
and the department remained in their offices for hours after everyone else
had left.  "Golden Handshakes" in the form of a joining or leaving present
used not to be used in IBM, though they have now crept in under the guise of
FAPs.
%
golf ball:  n. The removable typing element that was used in the Selectric
typewriter and the 105x series of System/360 consoles.  This typing element
is roughly spherical and is covered with the characters that can be printed.
Different fonts (such as Courier, Dance Symbols, Eskimo, etc.) are available
on different golf balls.  "When your program issues the WTO macro, the system
will jiggle the golf ball and print the message".  [A salesman of the old
guard would, of course, refer to "rotating and tilting the typing element".]
Golf Ball typewriters are no longer sold by IBM.
%
goodness:  1.n. A measure of a project's worth, used to justify its continued
existence when no rational reasons can be found.  "This system contributes
goodness to the user environment".  See also bad information.  2.n. An item
that is well esteemed, and unlikely to be unpopular with anyone.  [Like Apple
Pie?] "This project is Goodness".
%
granular:  adj.  Patchy, narrow minded.  In certain locations, to refer to
another person's thinking as "granular" is a subtle suggestion that it is
suspect.  One is encouraged these days to take a "system view" of thoughts
and ideas, where the whole is somehow greater than the sum of its (highly
granular) parts.
%
granularity:  1.n. A term with an indeterminate meaning.  Perhaps
"bittiness", by analogy with the grains of silver halide in a photographic
emulsion.  Usage (Quote from MVS/XA An Overview, GG22-9303, page 10)
"Read-only protection is now on a page granularity".  2.n. A substitute for
the word "specificity", in the sense "a specific item or detail".  Usually
coupled with descriptors such as "sufficient" or "a lack of", and in this
case used mainly to discredit someone else's work.  Not to be confused with
granulated.  3. n. Being able to fence out (of a configuration) a failing
element of a processor complex so the remaining elements can continue to do
useful work.  For example, in the 3081 one of the two central processors can
be fenced out and the other, in conjunction with the rest of the elements,
can continue to run as a single processor system.  Also on the 3081
processor, a pair of BSMs (Basic Storage Modules) can be fenced out, powered
down, repaired, powered up, tested, and returned to the operating
configuration.  Thus high granularity implies many elements that can be
fenced out, and low granularity implies few elements that can be fenced out.
%
green card:  n. Quick reference summary information printed on a large folded
sheet of heavy paper, usually yellow or white.  This refers to the original
(green) System/360 reference card which is an outstanding example of the
genre.  Some recent "cards" are in fact booklets - which of course tends to
defeat the object of providing a quick reference.  The original green card
became a yellow card when the System/370 was introduced, and soon was
published as a (yellow) booklet.  With the introduction of XA, it has become
a 48-page pink book.  A fine anecdote refers to a scene that took place in a
programmers' terminal room at Yorktown in 1978.  A physicist, using a
terminal there, overheard one of the programmers ask another "Do you have a
green card?".  The other grunted, and passed the first a thick yellow
booklet.  At this point the physicist turned a delicate shade of olive and
rapidly left the room, never [it's said] to return.  See also card.
%
green cloud:  n. Dollars budgeted for but unspent at the end of the year.
There is a very strong incentive to spend such funds, regardless of any
expense cuts or exhortations to economise that may have been received.  If
you don't spend the money, your organisation will be rewarded by the logic
that since it didn't spend it, it obviously didn't need it - and cannot
possibly need it next year, either.
%
green ink:  n. Any part of a software product (that is itself part of the
Systems Application Architecture, SAA) that does not conform to the SAA
definition.  So called from the use of green ink in the manuals describing
such products; deviations from the architecture are printed in green ink.
Informally extended to the concepts of "light green" and "dark green" -
deviations from the architecture that will be easy or hard to correct in the
future, respectively.  See also green words.
%
green layer:  n. Application enabling (support) software.  See layer.
%
green lightning:  n. Apparently random flashing streaks written on the face
of the 3278 and 3279 terminals while a programmable symbol set is being
loaded.  This hardware bug was not fixed, as some bright spark suggested that
this "would let the user know that something is happening".  [It certainly
does.] See also lightning bolt.
%
green machine:  n. A piece of hardware designed or modified to meet U.S.
Government military specifications (milspecs).  The name is derived from the
observation that the U.S. Army used to paint most of its property a drab
olive-green colour.  Usually refers to equipment produced or modified by the
Federal Systems Division.
%
green money:  n. See blue money.
%
green sheet:  1.n. The Travel Expense Allowance (TEA) multi-part form used in
the USA to submit expenses for reimbursement.  The only IBM form in the USA
(and possibly in the world) that was printed on green paper (now in green
ink), possibly to remind the user that it deals with "real" money.  Usage
"Just go out and buy it and we'll put it on the green sheet".  2. v. To
submit an expense for repayment.  "Go ahead and green-sheet that item".  3.
n. A sheet of ceramic, with binder, that is used in the manufacture of
integrated circuit chip carriers.  These are pale green, with a texture
rather like a thin vinyl sheet.
%
green words:  n. A widely used but now obsolete FORTRAN term for "parochial
control words used to delimit spanned records in the absence of adequate data
management support".  During a presentation in which these words were first
identified, they were diagrammed on a blackboard in green chalk, thus the
name.  It is reported that the Green words are the Block and Record
Descriptor Words (length fields) that are present even today in RECFM=V, VB,
and VBS data sets in MVS.  See for example the section "Variable-Length
Records" in OS/VS2 MVS Data Management Services Guide, GC26-3875-1, pages
9-15.  FORTRAN programmers needed to know about these in order to calculate
the proper LRECL and BLKSIZE values, and many were accustomed to "adding 4 to
get LRECL and 4 more to get BLKSIZE," thus producing unblocked disk-eating
horrors.  See also green ink.
%
grey elephant:  n. The Model 407 accounting machine.  So named because of its
size, colour [all IBM machines in those days were grey], and ponderous
operation.  This machine was programmed using a plug board and patch wires,
by a person known as a board wirer.
%
grommet:  n. A small, black, rectangular piece of rubber (without a hole in
it) that is used to prevent magnetic tape unravelling from its reel.  See
also sugar cube.
%
groove-swing:  n. (Meaning obscure.) This term was used repeatedly in a 1984
talk by a high-level personnel person as part of the persuasion patter
intended to convince engineers that they were Executive Resources.  The
speaker could not believe that the engineers did not see executives as the
highest form of life in IBM, so phrases like "the groove-swing leads right to
the power curve" flew fast and furious.  The speaker didn't seem to know what
the terms meant, and the audience certainly had no idea, so a proper
definition will have to wait for later enlightenment.  [Groove-swing is
probably from the golfing term, as in the usage "He's doing it so easily, he
must be in a grooved swing".]
%
growth:  v. To be grown, or to be extended.  As in "The most interesting
characteristic of these new processors is their ability to growth to up to 2
MB of main storage".
%
guru:  n. A professional expert.  There is significant difference between a
"guru" (who can invent new incantations), and a "wizard" (who can only use
incantations already invented).  Guru is overtly a term of respect, but can
sometimes convey an undertone of contempt for one who would invest large
amounts of time in a subject which the speaker does not consider sufficiently
important to learn well himself.  See also expert.
%
halfword:  n. Two bytes (an IBM System/370 Word is 4 bytes, or 32 bits).
Especially confusing term when used to describe a 16-bit data item on a
16-bit machine whose "word-length" is 16 bits.  See also fullword,
doubleword.
%
hall talk:  n. Gossip, especially concerning information that is widely known
and/or believed but has not yet been announced formally by the management
team.  The term derives from the favoured locale for such talk (in office
hallways, near rest areas and vending machines).  As in "There is hall talk
that we will have to slip the schedule".
%
hamster:  n. An incorrectly attached (or, more usually, detached) wire in a
computer system.  This is a local reference to the hamster, belonging to one
C. Moon, which all unknowingly chewed through electric wiring at home.
%
hands-on:  1.n. Time spent in exploration of a new piece of equipment.
"After the class we will go down to the DP Centre for some hands-on".  2.n.
Physical access to equipment.  "I have the programs written, but I can't get
any hands-on until Thursday".
%
handshake:  v. To communicate with the proper protocol.  Normally used to
indicate that two computers have been connected successfully, as in "OK, the
boxes are handshaking now".
%
hard disk, hard file:  n. A magnetic storage disk which is hard (not floppy),
and usually is not easily removable from the machine in which it is
installed.  See file, fixed disk, floppy disk.
%
hardwire:  v. To code as a constant value something that one would normally
like to be a changeable parameter.  From hardware-wired.  "The Userid of the
receiving machine is hardwired as DATASTAG".  "The spool space constant is
hardwired at 53%".  (An alternative term is hardcode).
%
he:  n. A huge computer program (e.g., MVS, HSM, JES) which does things on
your behalf, usually without your knowledge, and sometimes without your
control.  Perhaps originally an indirect reference to the programmer, but now
refers to the program - which seems to take on the personality of an unnamed
and devilishly cunning person when its side effects (the ones that are
causing you problems) are being explained to you by another.  "He dynamically
retrieves the datasets that you will need and puts them on a scratch pack".
Sexist programmers slip in the term "She" from time to time, either for
variety or when the action taken by the system seems especially fickle.
%
head:  n. The part of a hard disk drive mechanism that contains the coil that
actually reads or writes information on the disk.  This part "flies" on a
film of air, extremely close to the disk; hence the risk of a head crash.
See also fixed head.
%
head crash:  n. An event in which a read/write head forgets how to fly over
the surface of a magnetic disk, and gouges up priceless data.
%
headcount:  n. The number of personnel currently allocated to a manager or
project (whether or not the allocation is filled by warm bodies).  Headcount
is the primary measure of the size of a person's empire or the importance of
a project, and is therefore increased whenever possible.  Unfortunately it is
a common belief, among those who allocate resources, that nine women can
produce a baby in one month.
%
headshape:  v. To alter another person's opinion on a subject.  Permission
from the other person is not required (and probably not available).  There is
even a non-verbal form in which the shaper grasps the object's imagined head
by the ears, using the fingers and palms, and then massages the object's head
with the thumbs.  Neither the term nor the gesture should be used in the
presence of one whose head is to be shaped.
%
hear:  v. To understand and sympathise with.  Invariably followed by "but",
as in "I hear you, but there just isn't time to fix that problem".  This
usage probably derives from Erhard Seminars Training (est) 1971 jargon.
%
heat:  n. Reprobation from on high.  "If we can't ship this on schedule, we
are going to take a lot of heat".  Note that being cold-blooded helps one
withstand heat.  See also help.
%
help:  1.n. Something provided by headquarters staff, especially during times
of difficulty.  Often this term is used in conjunction with the observation
that "If we don't improve this product plan, we will get more Help than we
can imagine".  Alternatively, it may be heard in "I'm from the region / plant
/ headquarters and I'm here to help".  See also external audit, heat.  2.n.
On-line explanatory or reference material.  Usage "The program seems to work
OK, but the helps are awful".  Or "The help didn't tell me there is an
arbitrary restriction on the number of items a list tag can contain in a
NAMES file".
%
hero territory:  n. A marketing environment or sector where it is very easy
to make a name for yourself but where you run a real risk of visible failure.
The chance of an assignment to hero territory is often introduced by
management with the phrase "Have I got an opportunity for you.."..
%
hex:  adj or n. Hexadecimal, or base-16.  An alternative to the term
"sexadecimal".  This latter term was popular in the early days of
programming, when the abbreviation was a source of gentle amusement among
those few specialists who wrote programs.  With the more widespread use of
computing at the time of System/360, IBM invented the safely laundered term
"hex".  Not intended as a curse or incantation, frequent evidence to the
contrary notwithstanding.  In fact, neither "hexadecimal" nor "sexadecimal"
was derived logically.  The original term for the base 10 system was "denary
system", from the Latin partitioning number, denarius.  However, the term
"decimal system" became popular for base 10, while "binary system" was
accepted for base 2. When it came time to invent a name for base 16,
engineers with little Latin and less Greek stuck a randomly chosen word for
six from either Latin sexa- or Greek hexa- to the word decimal to create the
mongrel word hexadecimal.  A morphologically correct Latin word for "sixteen
each", corresponding to "binary" or "denary", would perhaps be "senidenary".
If the term were to end in "decimal", then the correct prefix would be
sexti-, as in "sextidecimal".
%
hexit:  n. Hexadecimal digit (0-9, A-F).  Calling this set of base-16 numbers
"digits" sounds bizarre, since they have more elements than you can count on
your fingers (unless you are involved in keyboard design).
%
hiccup:  n. A file duplicated by a network following a transmission error.
This is usually due to a forwarding program resending a file when
acknowledgement of receipt of the original copy fails to arrive, even though
the original copy did arrive.
%
hidden agenda:  n. The true purpose of a meeting or announcement.  "To
maintain integrity, all Software Change Requests will be signed off by
executive management".  The hidden agenda in this proposal is "We don't want
to see any more changes".
%
high level:  1. adj.  Global rather than local (describing a view of a
business situation).  2. adj.  Having at least three levels of subordinate
managers.  3. adj.  Of a modification or change to a product or plan having
no real value, but added to impress higher management.  As in "This is a
high-level feature".  See also bells and whistles.  4. adj.  Of no real
substance, or purely rhetorical.  As in "a high level discussion".  This
usage is possibly derived from the term "high-brow".
%
highlight:  v. To emphasise, or make a point of.  From the most common form
of emphasis available on older display terminals, in which the words to be
emphasised are brighter than the other information on the display.
Highlighting on displays now encompasses such diverse forms of emphasis as
underscores, reverse video, and (painful) blinking - but no longer
intensification.
%
hit:  1.n. An error in hardware or software.  "My system took three hits
before it crashed".  See check.  2.n. A Slip caused by an unsatisfied
external dependency.  Usage "I've got a [schedule] hit because of XYZ
slippage".  A highly desirable way to decommit, as it saves face.  See also
bad information.  3. n. A success in searching for something.  "Every time a
cache hit occurs, we save three cycles".  4. v. To press (a key or button),
as in "Please hit ENTER".  Now discouraged, as it is considered to be a word
that might disturb the sensitive user.  "Press" is the preferred verb, with
"Touch" a near second.
%
hobby:  n. A project outside a manager's normal line of responsibility which
can be pursued without using enough resource to attract attention.  Depending
upon the level and charisma of the manager concerned, hobbies can easily
involve dozens of people.  If discovered prematurely, a hobby is quickly
packaged as adtech and held to be an example of the innovation and
entrepreneurship that makes a company successful.
%
hokey dial:  n. A means of connecting terminals over a switched-line network
(usually the public telephone system), when the terminals concerned are
designed to work only on a permanently connected ("leased") line.  To achieve
this, the user manually dials the connection and then starts up the
communications, and the hardware at each end hopefully cannot detect the
difference.  Used as emergency fall-back in some cases where the dedicated
lines fail; also used as a cheap substitute for proper lines.  National
communication authorities do not always approve.  (Also called
pseudo-leased).  [The word "Hokey" comes from the sham Latin "Hocus" (as in
hocus-pocus, a magician's formula or trickery), which can also mean to cheat
or stupify with drink.]
%
home-grown:  adj.  Of software written for internal use and hence not
formally supported.  Of course, this software is often at least as well
supported as product code, but even so the description "home-grown" is often
used as an excuse for not using new and innovative tools.  See NIH, type one.
%
hook:  1.n. A piece of hardware or software which is added to a product to
allow future extensions or additions, but which is not necessary for the
basic function.  Unless designed very carefully, hooks can disclose planned
but unannounced features.  For example, many well labelled hooks in the
System/370 Model 145 microcode revealed a thing called Virtual Memory.  Now
for Quality's sake, hooks must be fully tested by the manufacturing
department involved.  2.n. The character "?", a question mark.  Generally
used by PC bigots, since in the old BASIC language the hook could be used to
pull the value of a variable out of the otherwise intractable interpreter.
See also shriek, splat.
%
hop:  n. An electronic network connection between two adjacent nodes.  This
is used as a measure of the logical distance between two nodes, as opposed to
the geographical distance.  This distance is a good indication of the likely
file transmission delay (netlag), which is closely correlated with the number
of times that the file will be stored and then forwarded.  Some machine rooms
feature systems which are three or four hops apart, even though you can't
open the doors of one of the mainframes without first closing those of the
other one.
%
horizontal:  adj.  Broad or wide.  See vertical.
%
hot and heavy:  adj.  Intensive, hard and steady.  Used frequently [and,
apparently, quite innocently] at a Minnesota location to describe intensive
work to meet a deadline.  As in "We've been going hot and heavy on this for
six months now".
%
hot button:  n. A topic currently of great interest to someone who matters
(i.e., some big-shot).  Implies impermanence, and some contempt.  The hot
button of today is likely to be of only minor interest tomorrow.  Current
examples ease-of-use, Quality.
%
hot key:  1.n. A keystroke (or combination of keystrokes) that switches
environments.  On the PC, terminal emulators often have a hot key to swap
between the PC-DOS environment and the host environment.  In System/370
jargon those keys are sometimes referred to as "Program Access" keys.  These
keys are probably called "hot" because they are always active.  Certainly if
pressing them has no effect, the underlying program or machine can be
somewhat cold.  2. v. To switch environments.
%
how hard would it be:  adv.  A plaintive litany used when venturing
suggestions for changes.  Immediately precedes some preposterously difficult
proposal which to the requestor (and any other reasonable person) seems
simple.  From experienced users, a wry acknowledgement that the proposition
may well be costly, but is nevertheless desirable.  "How hard would it be to
remove the length restriction on userids?" See also WIBNI.
%
huff:  v. To compress data using a frequency dependent or Huffman code.  "If
the data won't fit in the record, we can always huff it".  The abbreviation
derives from the first of a pair of programs written in the 1970s to compress
and restore data, delightfully named HUFF and PUFF.
%
hung:  1. adj.  Not responding to requests.  As in "The system seems to be
hung now".  The term derives from telecommunications; a computer that drops
the telephone line to a user's terminal is said to have hung up the line (as
though it had hung up the receiver on a telephone handset).  2. adj.
Waiting, queued.  An excuse for "lost" electronic mail files.  As in "Your
file must be hung at some intermediate node".
%
ibmox:  (eye-bee-em-ox, ib-em-ox, or ib-mox) v. To copy xerographically.  "I
Xeroxed a copy - sorry, I ibmoxed a copy of that report for you".  Also
ibmrox.
%
icon:  1.n. A sequence of characters used in computer conferencing to add
emphasis or to convey the writer's tone-of-voice (also known as an emotion
icon or emoticon).  For example, the sequence -) (when viewed sideways) looks
like a smiling face and hence warns the reader that a comment is meant
lightly or sarcastically.  A poor substitute for properly written language,
but convenient and widely used.  2.n. A small symbol for a program or for
data.  [These are not originally IBM terms, but are included here due to
their wide usage.]
%
iconize, iconicize:  v. To render, change, or otherwise cause the appearance
of an area of displayed data on a screen to be transformed into a (usually
smaller) symbol, known as an icon, for the original data (or for the program
which presented that data).
%
impact:  n. See hit.
%
in-plan:  adj.  Of a task formally agreed to and planned to be accomplished
by some date.  What marketing wants.  In general What somebody else wants.
See also out-plan.
%
incantation:  n. A small piece of source code that appears in most programs
written in a given language.  Most programmers will use the sequence out of
habit, and often without thought or understanding in the hope that it will
ward off evil spirits and bugs.  One example is ALR *,R12 SING R12,* pre>The
term is also used for any piece of expert manipulation required of a user or
reader get access to a privileged system function or information.
%
incent:  v. To motivate with the carrot.  [A horrible term, but perhaps it is
preferable to "Incentivize"!]
%
increase:  n. An addition to one's salary.  "Your performance will have a
direct effect on your increase".
%
incredible:  adj.  A famous memo issued by FE management suggested the word
"Incredible" as a possible alternative to the term "Bull" and its
derivatives, which apparently was being over-used in meetings.  Thereafter,
the exclamation "Incredible!" could be heard ringing through the halls,
accompanied by merriment from those understanding the translation, and
expressions of bewilderment from the others.
%
individual:  n. Person.  As in "Several individuals are upset by this".  IBM
always respects the individual.
%
inflatable buildings:  n. Temporary buildings.  A term used in Poughkeepsie
(where there are lots of them) because they go up so fast.
%
informatize:  v. To pass information to.  "Can you informatize your people
before we announce?" See also level set.
%
inherently familiar:  n. user-friendly.
%
inking engine:  n. That part of a computer printer (especially ink-jet
printers) that is concerned with getting ink (or "toner") onto the paper.
%
innovate:  1. v. To change for the sake of change, preferably making previous
programs or systems malfunction.  2. v. To introduce a new product at least
three years behind the competition.
%
insipidize:  v. To dull.  Usage (mostly in marketing departments) "Our claims
have all been insipidized by Legal".
%
inspection:  n. A meeting in which the design or implementation of a product
or document is reviewed in detail.  Generally, there are three levels of
inspection for a product.  The first, usually called "I0" (eye-zero), takes
place when the specifications of the product are complete.  The I1 inspection
reviews the design of the product.  The I2 checks the actual implementation
(in the case of a code inspection, every line of code is scrutinised).  An
inspection is chaired by a Moderator (usually from a Product Assurance
department) and comprises the author or authors of the object being inspected
together with at least an equal number of independent reviewers.
%
install:  n. The process of installing a machine, including making
connections to it, loading any required software, and testing the completed
installation.  As in "Who's doing the install?"
%
intelligent:  adj.  Programmed or programmable.  The document IBM
Publications Guideline Style (ZZ27-1970-0) prohibits use of this adjective in
external publications.  It recommends the use of "programmed" instead.  For
instance, one should not write "This department is full of intelligent
people" but rather "This department is full of programmed people".
%
interactive:  adj.  Modern.  Usually associated with typing at CRT display
terminals.  Supposed to carry the connotation of fast, pleasant, and making
full use of "modern" techniques and technology.  Usage "Of course, we will
follow up with an interactive version".
%
interface:  1. v. (Of humans) To talk.  "I'm going to interface to Joe Bleh,
the new DP Manager".  2. v. (Of machines) To connect.  "I'm going to
interface the black box to the [big] blue box".  3. n. A legally defined and
documented place on an IBM machine or program where someone can attach
another machine or program, of any manufacture.  Programmers often call this
a user exit.
%
internal:  adj.  Internal or proprietary to IBM.  Usage "We use the internal
version of that - don't you?"
%
interrupt:  n. An event that interrupts the normal flow of control in a
program or software system.  "The timer interrupt is used for sampling the
execution profile of the application".
%
interrupt mode:  n. The state of only being able to react to events rather
than anticipating or guiding them.  As in "I'm in interrupt mode all the time
these days; never get a chance to do anything creative".
%
iron:  n. Computing machinery.  Prevalent among hardware people to describe
"boxes" (blue or otherwise).  Hence pour iron, as in "To some degree, we can
`pour iron' on the problem".  See also big iron, micro iron, old iron, pig
iron, push iron, rusty iron, tired iron.
%
ironmonger:  n. A derogatory term used by some "pure" software people to
designate hardware people.  One who makes or sells iron.  This usage
generally indicates that the speaker is ignorant about hardware matters.
%
issue:  n. A formal indication from one group to another that the first is
dissatisfied with some action by the other, and is prepared to take the
matter to the next level of management to resolve the problem.  Issues are
often solutioned.  See also concern, exposure, non-concur.
%
ivory letter:  n. See blue letter.
%
jaws chart:  n. A planning graph portraying time on the horizontal axis
against resources or volumes, etc., on the vertical axis.  Two lines,
representing the planned or projected requirement and the actual resources
available, inevitably leave a wedge-shaped gap reminiscent of an alligator's
open jaws.  This delta is often labelled by the lower echelons as "shortfall"
and by senior management as "opportunity".
%
job rotation:  n. Moving people from one job to another.  A management
strategy commonly used when a new and creative manager takes over a
department that has many people who have been sitting at the same desk for
too long.  A policy of job rotation is initiated, so that the old hands can
be moved to new jobs (usually good for them and for the company).
Unfortunately, for consistency, the rotation rules also have to be applied to
the new blood that replaces them, and the resulting insecurity is not always
advantageous.
%
joggle:  v. To shake or disturb slightly.  Once used to describe the
technique for squaring up a deck of punched cards, it now refers to agitating
a person into doing a task or making a decision.
%
joint study:  n. A study made in conjunction with a customer to try out a
program or piece of hardware during the development cycle.  This is one of
the best ways to ensure the quality of a product, as it gets used by real
users.  The customer gets the benefit of having his problems solved earlier
than he might otherwise expect, and IBM gets the benefit of hearing about the
customer's experiences (so long as somebody listens).
%
jumper:  1.n. A removable small wire or plug connecting two pins that
modifies an electrical circuit to affect some function.  For example, to
change the address by which a peripheral device is known.  Now largely
superseded by micro switches and "software jumpers".  2. v. To place or
remove one or more jumpers.  As in "Is this card jumpered for high speed or
low speed?"
%
k, K:  adj.  1000 or 1024.  The lower-case "k" is the internationally agreed
abbreviation for the prefix "kilo" (as in kilometre, kilogram, meaning 1000
metres or 1000 grams).  The upper-case "K" is never the correct abbreviation
for "kilo", and has come to mean the number 1024 (two to the power of 10).
Computer memory (storage) is addressed by binary encoding so this is a
convenient unit, close to the familiar 1000.  Hence 64K + 64K = 128K (= 131k,
approximately).  See also m, M.
%
kahuna:  (ka-hoo-na) 1.n. A Hawaiian witch doctor.  2.n. An expert in some
narrow field of endeavour, or one who runs things.  A top expert is a big
kahuna.  (Kahunas have much understanding of the conflict of "K" versus "k".)
See also guru.
%
key:  adj.  Important.  Derived from the old term "key part" in theatre, it
is used when the speaker cannot explain why it is important.  "It's
absolutely key".
%
key off and key on:  v. To reset a machine by the use of its on/off key.
This does not necessarily remove power from the machine, but may well
re-initialise its hardware and software.  Usage "Why don't you key off and
key on that 6670 and see if that fixes it?" See also Big Red Switch, POR,
Poughkeepsie reset, power cycle.
%
keyboard:  v. To enter data by pressing buttons on a computer input device.
This was originally used to describe the work of card punch operators, now
applied to any relatively large scale data entry work.  "We are keyboarding
the Oxford English Dictionary in Florida".
%
keys to the kingdom:  n. The access authority that allows control of special,
usually privileged, functions in an operating system.  Often has the form of
a password needed for maintaining the system, correcting problems, etc.
%
kick-off meetings:  n. An epidemic of meetings early in the year, originally
in the marketing divisions, when senior managers seek to persuade their staff
to face the year's challenges.  Usually the only time such managers are
actually seen in the flesh (apart from award conventions).  Can be relied
upon to provide a reasonable lunch.  In small countries kick-offs take place
in the first week of January.  In larger countries there may be a delay of a
month or more while the managers ensure they still have jobs, and find out
who the customers are, following the latest annual reorganisation.  A modern
trend is to have a minor show-business celebrity, carefully selected for
total ignorance of IBM and its jargon, to compere [introduce and tie together
the parts of] the meeting.  This is to encourage more attention to end users.
%
kill a tree:  v. To generate a large quantity of printed material.  A
sardonic way to refer to the running of a program that prints indefinitely or
produces a timing chart for a hardware simulation run.  See also sequoia,
three-tree report.
%
killer machine:  n. A service machine that checks for idle userids and forces
them off the system.  Killer machines usually just stop other service
machines (especially the newly installed ones which did not make it to the
exclusion list), since canny users quickly learn to run a looping exec to
avoid the chop.
%
kipper:  suffix.  A measure of the speed of desk-top 370s and minicomputers
that do not manage to achieve a million instructions per second.  A "KIP" is
a thousand (kilo-) instructions per second (see note under MIPS), hence a
"300-kipper" is a machine that runs at 0.3 MIPS.
%
kit:  1. v. To collect in one package all the parts needed to build some
machine or subassembly.  One person (rather than an assembly line) then does
the whole job of assembling the item.  This manufacturing process is called
"kitting".  2.n. (When used in the field) Any piece of IBM hardware or set of
boxes.  As in "We must get the kit in by Friday to beat the installation time
record".
%
kludge:  (to rhyme with stooge, not fudge) 1.n. A quick-and-dirty fix; a
clever but inelegant solution.  Often applied to one's own work in
self-deprecation.  This is derived indirectly from the German klug, meaning
"clever".  [This sense is not originally IBM jargon, but is included here by
popular demand.  It is interesting to note that the probability of the
incorrect pronunciation (to rhyme with fudge) increases with the square of
the distance from Cambridge, Massachusetts.] 2.n. Something large and
complicated.
%
known:  adj.  Almost ready for Announce.  As in "Yes, that's a known
requirement" (emphasis on "known"), i.e., "We are working on that, but we
can't announce it yet, so you'll have to read between the lines".
%
known restriction:  n. A bug which was discovered after installation/shipment
of a system, but which cannot be described as a feature, and which is so deep
in the machinery that it will take a major re-write (and hence be very
costly) to correct.  "Yes, it wasn't meant to work that way.  It's a known
restriction".
%
la cage aux foils:  n. The European Headquarters building, the Tour Pascal in
Paris.  Perhaps a pun on cage aux folles, a madhouse.  See also foil, Foil
Factory.
%
lay down:  v. To install a new version of a program by copying it from a
distribution tape to a disk.  Usage "I've got to lay down the new release of
VM today".  There is little analogy with the laying down of vintage port - a
given version of a program never improves with age [though it may seem to
throw a crust].
%
layer:  n. A collection of hardware or software that can be considered to
form a layer within the structure of an operating system or architecture.
Conceptually, layers are smoothly overlaid on each other with a clean
interface between each, as in an onion.  Upon detailed inspection, however,
it will be seen that the globe artichoke is often a more accurate model.  In
the late 1980s, SAA was described in terms of a number of layers, labelled by
colours.  See black layer, blue layer, green layer, red layer, yellow layer.
%
layered architecture:  n. An Architecture in which a set of sections is
defined, each section ("layer") representing a distinct logical function.  In
theory each layer covers (and hides) the machinery of lower layers, so you
only need to know the highest layers necessary to perform the function you
require.  In practice you usually still need to know about all the layers to
get anything to work, since all the interfaces are exposed - which rather
defeats the intention.
%
leading-edge:  adj.  At the forefront of innovation and technology.  Used to
describe technology that is four years out of date and is therefore mature
enough to be used in a product.
%
leave the business:  v. To leave IBM.  See also terminate.
%
letter of understanding:  n. See document of understanding.
%
level:  n. A number assigned to each job or position that indicates the
seniority and salary scale of the employee filling that position.  Like
salary figures, a person's level is considered a private matter unless that
person wishes to discuss it.  However, many job titles correspond directly to
specific levels.
%
level one:  n. The first level of customer support, the person who first
handles a problem.  If a customer has a real problem, he has to somehow get
the level one person to refer the problem to a real guru, the level two
support.  If IBM also considers the problem significant, the customer may
then be level two'd.
%
level one miracle:  n. An occasion when, on calling a level one support
group, the Level One person solves the problem immediately.  This is becoming
far more common than it used to be as the databases and information systems
available to the support groups continually improve.  See RETAIN.
%
level set:  v. To get everyone to the same level of knowledge or background
to be used as a base for further progress.  That is, to give a short talk to
define terms, etc.  "Before you start, let's level set everyone".
%
leverage:  1.n. Commercial advantage.  As in "We could use bipolar or CMOS.
John, what's the bipolar leverage?" 2. v. To lever (upwards).  As in "Let's
leverage sales of our project by tying it to the others".
%
light pipe:  n. A cable made from a fibre optic bundle.  As in "We're putting
a light pipe between building 24 and building 9".
%
lightning bolt:  n. A warning signal that looks like a flash of lightning.
It is used on the IBM 3270 range of terminals to signify a communication
error.  For example "lightning bolt 505" probably means that the system to
which you are (were) connected just crashed.  Also called shazam, a magic
word used by the comic-book figure Billy Batson; when he spoke it, lightning
struck him and transformed him into Captain Marvel.  See also green
lightning.
%
limited duty sticker:  n. A device added to an employee's badge to indicate a
member of the Quarter Century Club [open to those who have been employed by
IBM for 25 years or more].
%
line item:  n. A major part of a new release of a (usually software) product.
One of the highlights.
%
line management:  n. Lower levels of management.  Those levels between the
speaker and the listener.  "You should take this matter up with your line
management".  As with following the line in a strictly hierarchical menu or
file system, following a management line (chain) can often introduce delays
and frustrations.  See also first-line manager, nonlinear.
%
line of code:  n. A line of a program that contains information (i.e.,
excluding blank lines, etc.). A measure of programmer productivity or program
complexity.  Many people still estimate the complexity of a program by the
number of lines of code that it contains.  There is certainly some
approximate correlation between the number of lines of code, the number of
bugs to be expected, and the time it takes to write the code.  These measures
are more or less independent of the language of the code, so that (for
example) 1000 lines of Assembler Code will take as long to write as 1000
lines of PL/I, and be approximately as reliable (though the Function provided
may be less).  Fortunately, this relationship is becoming less true as
languages improve and become better engineered for human use.  The terms loc
(lock, loke) and kloc (kay-lock, kayloke) are also used to refer to one or a
thousand lines of code respectively.
%
line, the:  n. The boundary between storage whose address is greater than or
equal to 16777216 (16 Meg, hexadecimal 1000000) and storage whose address is
less than 16777216 (below the line).  Since the original System/360
architecture used short (24-bit) addresses, much software was written with
the assumption that no addresses could be higher than 16777215.  With the
introduction of XA (extended architecture), some machines allow 31-bit
addresses, but very many programs are unable to make use of the storage above
the line, due to earlier assumptions.  "The interpreter is written for 31-bit
addressing - why can't it run above the line?" Also used to describe the 640
Kilobyte line in the IBM PC address space.
%
linend:  n. The End-Of-Line character.  In EBCDIC, each line (where not
directly supported by the file/storage system) is ended by a single
character, the linend.  This is equivalent to the various combinations of
Carriage Return and Line Feed used in ASCII.  "Linend" may refer to the
EBCDIC code '15'x, or it may refer to a displayable character that translates
to the true line end (such as the number sign, also known as the hash sign,
pound sign, octothorpe, or tic-tac-toe sign).
%
link:  n. A network connection between two machines.  Usage "Is that link
down again?"
%
lion food:  n. Middle management or headquarters staff.  This usage derives
from the old joke that goes something like this Two lions escape from a zoo
and split up to improve their chances, after agreeing to meet after two
months.  In due course they meet again.  One is skinny, but the other is
somewhat overweight.  So the thin one asks "How did you manage?  I ate a
person once, and they came searching the whole country for me.  Since then, I
have had to eat mice, insects, and even grass".  "Well," answers the obese
one, "I hid near an IBM office, and preyed a manager a day.  And they never
noticed".  See also food chain.
%
listing:  1.n. A hardcopy (paper) print-out, usually of a program or
algorithm.  2.n. The assembler- or machine-language part of such a print-out.
%
load:  n. A person who stands in the way of production, and who generally
slows down the work rate of everyone else.  The term is derived from
electrical engineering, and corresponds to the popular "weak link" concept.
Most commonly heard in East Fishkill, as in "That person is a real load".
%
load-and-go:  1. v. To run a program in a single step that links its
components together and then runs the complete module.  "Can you load-and-go
a module in this system?" 2. adj.  Easy to get started, so that you can just
walk up and use the equipment.  As in "This is a load-and-go system you just
load it down and go to the phone to order more software".
%
lobotomy:  1.n. The process whereby employees "with management potential" are
taught the meaning of life, management, and everything.  Commonly used by
both management and others, this term implies that the student will, on
return from the course, no longer act like a real person and will have lost
the capability of independent action.  "I had my lobotomy last week, so don't
ask me why - just do it".  2.n. The logical disconnection of the two halves
of a 3084 or a 3090-400 processor.  "You mean that after it has been
lobotomized, one could IPL VM in one half and MVS in the other?"
%
locked and loaded:  adj.  Of a disk drive ready for use.  Refers to the steps
involved in preparing to use a removable hard disk file.  First the disk is
placed on the drive and locked into place, and then the "Load" button is
pressed.  This closes the drive (if necessary), brings the disk up to
operating speed, and finally loads the read/write head.  [A reader recalls an
Army usage of this term, for a rifle that was ready to fire.  Unfortunately,
since the term referred to locking a magazine of twenty bullets into place,
it was applicable only to an M-16 rifle, and not to a Winchester.]
%
logo software:  n. PC software sold under the IBM logo [logotype], which may
or may not have been written within IBM.  Software marketed by IBM but under
a different company logo is called non-logo.  For instance, Digital Research
Dr. Logo is a non-logo Logo.
%
long pole in the tent:  n. An activity that is on, or nearly on, the critical
path in a schedule.  When an organization is involved with other contractors
in a large project (as in Aerospace), it is Highly Undesirable for any of
that organization's tasks to become the long pole in the tent.  Presumably
this derives from the principle that the long pole is under the most stress,
and (more importantly) is the most visible.  "We don't want IBM to be the
long pole in the tent on this one".
%
loop:  n. See closed loop.
%
loss review:  n. A marketing division procedure, used to determine why a
customer selected a supplier other than IBM.  A meeting to avoid, if at all
possible.
%
lots of MIPS, no I/O:  adj.  Of a person technically brilliant but lacking in
social and communications skills.  Literally lots of processing power but no
Input/Output.  See MIPS.
%
low acoustics:  n. Quietness.  From the 9370 blue letter "The rack-mountable
IBM 9370 processor is uniquely designed for an office environment, having low
floor space and power requirements, low acoustics, and an attractive,
modular, systems package".
%
low cost application platform:  n. Some kind of operating system.  The exact
meaning of this has not yet been discovered; it was used in a product
announcement to refer to a System-Programmerless operating system to which
you can add other [high-cost?] program products according to your
requirements.
%
lunatic fringe:  n. In Marketing, customers who will always take Release 1 of
any new IBM product.  The opposite of dinosaurs.  See also ESP.
%
m, M:  adj.  The lower-case "m" is the internationally agreed abbreviation
for the prefix "milli" (as in millimetre, meaning 1/1000th of one metre).
The uppercase "M" is the international abbreviation for "Mega", meaning
1000000.  Confusingly, in the computer industry, the "M" is also used to mean
1048576 (1K times 1K.) See k, K. When used in the form MByte it almost always
means the latter, but in other contexts its meaning is usually chosen to
benefit the writer.
%
machine check:  n. A failure in the basic hardware of a computer.  Automatic
recovery is usually, but not always, possible.  Also known, more loosely, as
a check.
%
machine code:  n. The lowest level of instructions formally defined as being
understood and acted upon by a computer.  There may be lower-level
instructions (microcode) understood by a particular computer implementation,
but machine code is the level that will be common across a series of
machines, such as the System/370 line.  See also code.
%
macro:  n. A template (with parts that can be included or skipped by
programming) that produces text by plugging the macro's arguments into slots
in fixed text.  The resulting text is then either considered as programming
language instructions (in assemblers or compilers), final output text (as in
text formatters), or as commands (system, editor, or program macros).  In IBM
it was, until 1979, fashionable to write macros in outlandish and preferably
unreadable languages, usually abounding with characters that are awkward to
type on standard keyboards.  This makes it appear very skilful to write
macros, when in fact the main attributes required are those of good humour
and considerable patience.  See also.
%
magic, FM:  n. A comment on a problem that solves itself.  As in "Things were
crashing all over the place earlier, but hey, FM, everything cleared up".
[The "F" modifier here cannot be found in certain "unabridged" dictionaries;
it can, however, be located in any good English dictionary, between
Frustration and Fulfilment.]
%
mainframe:  n. A large computer, usually shared between many users.
Originally referred to the central processing unit of a large computer, which
occupied the largest or central frame (rack).  Now used to describe any
computer that is larger than a minicomputer.
%
man-month:  n. An arbitrary unit of work (see Brooks, The Mythical
Man-Month).  Equivalent to the amount of work that an "average" programmer
could do in one calendar month.  May or may not take into consideration time
spent in meetings, technical exchanges, vacation, holidays, illness,
travelling, paperwork and design flaws.  It is of course assumed that if one
person could complete a program in nine months, then by putting another eight
people on the job it will be completed in one.  Now often called
person-month.  For large projects, the units "Person-Year" and
"Person-Century" can find favour.
%
manager:  1.n. Within IBM, strictly defined to mean an individual who has
other employees directly responsible to him or her.  Thus "Ms Smith is the
Manager of Mr Jones".  2.n. A title sometimes given to a person who needs to
sound important (to himself, herself, or others) but who is not important
enough to have anybody working for him or her.  Thus "Mr Fortescue-Smythe is
the Manager of Corporate Tiddlywink Sponsorship Programmes".
%
manager without portfolio:  n. An employed but unemployed manager.  The term
follows from the "Minister Without Portfolio" in the British Cabinet.
%
march along the path:  v. To take the official view of an issue (even though
not entirely agreeing with it) in order to show unity or loyalty to a
particular point or strategy.
%
mark of Kloomok:  n. Official indication that a product has been released
from PID.  After one M. Kloomok, the signatory to Shipping letters for many
years.  (The letters are no longer signed.) In one customer memorandum, a
person who was trying to emphasise the legitimacy of a product he was
referring to stated that it bore "the mark of Kloomok".
%
master:  n. The (or a) primary copy of a conferencing facility disk that has
one or more duplicates (shadows) at remote locations.  "You can get the full
version from the master".  See also catcher, pitcher.
%
math-out:  n. A piece of work so full of mathematics that the reader cannot
see anything meaningful anywhere.  (By analogy with "white-out".)
%
message war:  n. The long and monotonous conversation between two service
machines resulting from an implicit assumption by both that the other is a
human (and thus in need of guidance).  The messages can usually be translated
into English as "I did not understand what you said", repeated ad nauseam by
both sides.  If the message is short and the response time between the two
machines is also short, the conversation can rapidly overload the network or
the processors involved.
%
mickey:  n. One unit of displacement for a mouse.  Used in the industry for
some time, but made "official" in OS/2, where a system call is named
"MouGetNumMickeys".  [Perhaps one day the "disney" will become a unit of
measurement for animated graphics?]
%
micro iron:  n. Any 370 architecture machine hiding under the covers of a
personal computer.  This term has arisen mainly due to the announcement (on
18th October 1983) of the XT/370 - a System/370 processor plugged into an IBM
PC-XT - followed in 1984 by the announcement of the AT/370.  See also pig
iron.
%
microcode:  n. Any software the customer cannot get his hands on.  Originally
used to refer to the instructions (embedded in the hardware) that are at a
lower level than the machine architecture instructions.  With the advent of
RISC technology, and the increasing number of products shipped OCO, the
distinction between microcode and other code - already hazy - has almost
completely gone.
%
mid-air:  adj.  Unsound.  Used to describe a technologically or financially
shaky project, as in "That's a mid-air project".  This is a reference to the
phrase "feet firmly planted in mid-air" (rather than on the ground).
%
migration:  n. A movement from one level of a product to a newer level, or to
an alternative strategic product.  Migration is often needed, even if the
currently installed products are viewed as being completely satisfactory, so
that continued support will be possible.  Subtle "incentives" such as "If you
do not migrate we will be unable to support your installation" can be applied
to prod a customer or internal user into making the change.  Hardware
migration comes in three flavours "horizontal", where one changes to a model
of the same size in the new range of machines (for instance, from 3090-200E
to 3090-200S), "vertical", where the change is for a bigger model in the same
range (3090-200E to 3090-400E), and "diagonal", where the change is for a
bigger model in the new range (3090-200E to 3090-400S).
%
milk a mouse:  v. To pursue an issue which is trivial, inconsequential, or
uninteresting.  Most often used in a meeting where a much larger and more
important issue is to be discussed.
%
minicomputer:  n. Any machine with a non-370-compatible architecture that
runs under 3 MIPS.  Also mini.  [This definition is rapidly evolving, due to
the announcement of the 9370 office System/370 machines in October 1986.] See
also vector processor.
%
minidisk:  n. A portion of a (real, physical) disk that is available to a
virtual machine and which appears to be a real disk device.  A virtual disk.
%
mission:  n. A strange word used by IBM powercrats to imply "job",
"function", "strategy", or "responsibility".  Thus "It is this division's
Mission to produce low-cost widgets".  Fighting over the ownership of
Missions is a favourite (and in some cases the only) activity of many Senior
Executives.  "Mission" has the advantage over more mundane descriptive words
of implying a certain level of spiritual righteousness about the share-out of
the spoils of the fight, and is therefore usually spelt with a capital "M".
%
mixed case:  adj.  Of commentary, system messages, etc.  not all in upper
case, and therefore easy to read and understand.  Usage (prior to REXX, 1979)
rare.
%
mocha:  adj.  Enhanced flavour, i.e., a modified and improved version of a
program.  Approximately equivalent to chocolate, though some rate it more
highly.  Sometimes used in the phrase mocha almond fudge, as in early ISIL
documentation.  See also vanilla, flavour.
%
model:  n. A suffix to the four digit product number, used to distinguish
different varieties of the same product.  The suffix can be numeric,
alphabetic, or a combination of both.  There is usually no connection between
the suffix ordering and the size and performance of the unit.  For example,
in order of performance, the 3083 computer has models E, B, and J (in this
particular case, the letters are rumoured to be the initials of the project
manager).
%
modulate:  v. To change.  "Let's modulate our approach to this problem".
From the radio engineer's term for sending out a message by modulating a
carrier wave.
%
module:  n. A general purpose noun that can mean almost anything.  Some
current favourites a section of code; a package of circuitry containing one
or more chips; a unit of instruction; or a temporary building.
%
motherhood:  1.n. Condescension.  Used to describe a common attitude of
software development groups toward their underlings (i.e., the users of their
software).  It is attributable to the observation that designers often
believe their creations to be the "ultimate solution", to which no possible
improvement could be conceived.  "Why don't they distribute source code?" -
"Motherhood, pure motherhood".  2.n. Something that is good and true (cf.
fatherhood ) and should not raise any objections.  For example "I'll start
the pitch on testing our software with some motherhood about why testing is
good".
%
move:  n. A relocation (movement) of an IBMer from one office to another,
either to a new building or (more often) to somewhere in the same building.
As in "Has the move been delayed again?" A move takes a minimum of two days
of an employee's time half a day to pack up all the accumulated material
(junk) from desks and cabinets into fold-up cardboard or plastic boxes; a
quarter-day to cut out little squares and rectangles and tape them into a
model office so the movers know where to put the furniture when it is moved;
half a day, once the furniture has been physically moved from one office to
the other, to move it around to where it is actually wanted (rather than to
where you said you wanted it or where the movers left it); three-quarters of
a day to unpack the boxes back into the furniture - taking care to re-read
all those gems that only get read after an office move.
%
movers and shakers:  n. Those people who wear the power suits.  Usually (but
not always) the people whose ambition is only surpassed by their egos.
%
multiplex:  v. To switch one's focus between several tasks that are competing
for attention.  This lets one demonstrate the uncanny human ability to
totally mismanage a multitude of tasks simultaneously.
%
multiwrite:  n. Multiple write authorisation for a disk.  An especially
powerful way of accessing data on VM disks, usually outlawed.  Since it
allows more than one user to arbitrarily write on a disk, possibly without
any cooperation or heed for the other users, it invariably results in
mislaid, destroyed, or subtly corrupted data files.
%
musical systems:  n. A popular game played at some sites where people have
userids on many test [and, sometimes, production] systems.  The rules are
simple one moves from system to system until one finds a system which stays
up long enough to complete the logon procedure.
%
naive:  adj.  Having never used a particular system or program before.  This
does not have anything to do with the general experience or maturity of the
person.  "Ah, but can a naive user use it?" See also end user.
%
naive user:  1.n. Someone new to the computer game.  Usually viewed with a
mixture of sympathy and pity.  2.n. A person who cannot chew gum and walk at
the same time.  (When applied to someone not-so-new to the game.)
%
nastygram:  n. An (unwelcome) error message.  This term is used for cryptic
and "telegraphic style" error messages, especially when prefixed by an
identification sequence that distracts the eye.  There is no such thing as a
"Friendlygram".
%
need to know:  n. A reason supplied to justify access to restricted
information.  This phrase is most often wielded when someone wishes to avoid
passing on a piece of information, usually because the information would be
embarrassing.  "Do you have a need to know?"
%
needs of the business:  n. An undefined reason for not letting you have
something.  "No, you can't have five more headcount, because of the needs of
the business".
%
net:  v. To send by computer network (rather than by tape or by post).  "I'll
net you the files tomorrow".  See also VNET, snail mail.
%
net-net:  v. To summarise a presentation into less than twenty words.  An
interjection used by impolite executives to stop a meandering presentation
and find out what resources the speaker is really asking for.
%
net it out:  v. To precis.  A term used (mostly by managers) to denote a
strong desire to bypass understanding of a proposed solution in favour of a
simplistic quantification of it - as in "I don't want to understand all the
reasoning behind it, just net it out for me".  Higher level managers may
interchange use of this term with bottom line.  See also crisp up.
%
netiquette:  n. The "good manners" preferred when interacting with other
people on a computer network.  Netiquette deals with many things, such as the
length of distribution lists in PROFS notes, the size of the files sent over
the network, the habit of attaching a copy of every note to its reply, the
ability to spell, etc.
%
netlag:  1.n. The time it takes files to travel from one point to another on
an electronic network.  2.n. The result of one's internal (biological) clock
being out of synchronisation with local time due to working on an electronic
network.  For example, there is a tendency among European IBMers to live on
the USA clock in order to have a maximum working time overlap with their US
colleagues.  This means that they constantly look as though they just stepped
off an overnight flight.  3. n. The discrepancy in file timestamps between
the sender's copy and the recipient's copy.  See GMT-friendly.  Due to bugs
in transmission software or to systems having trouble adjusting to Summer
(Daylight Savings) Time.  (There are four changes a year between Europe and
North America.)
%
netrash:  (net-trash) n. Any file with useless contents, sent over a network.
The electronic equivalent of junk mail.  Some service machines are very good
at generating netrash, especially those which try to "intelligently" process
files aimed at non-existent userids.  Service machines have a considerable
advantage here, but, alas, humans have been reported to outperform them in a
number of cases.
%
netrock:  n. A strident complaint sent over an electronic network.  As in
"You should see the netrocks I'm fielding!"
%
new news:  n. Something that was left out of the last plan and which is
therefore suitable for presentation to management because they will not have
heard of it yet.  This is distinguished from old news, something that even
management knows about.
%
nit:  n. A task, such as improving the user interface to a program, that has
not yet been done and should be trivial to do.  As in "That's just a nit -
I'll fix it in that spare week before we ship".
%
no-brainer:  n. An exercise or test which ought to be easy for the student
but in practice tends to generate results which indicate that the student has
no brain rather than that the test requires no brain.
%
no-op, NOP:  (no-op) 1.n. No-operation.  An instruction to do nothing (used
to fill up space or time during execution of a program).  Often used to allow
space for later insertion of a break point or hook.  2.n. Something or
someone ineffective.  Usage "He's the biggest no-op I have ever seen".  3. v.
To make ineffective.  As in "I'll no-op that piece of code", or "I'll no-op
that group's objection".
%
no problem found:  n. A colloquialism used by Software/Hardware maintenance
people to indicate that they were unable to reproduce the users' problem.
Depending on the tone of voice used, a gentle or not-sogentle way of asking
for more information.  Also no trouble found.
%
nocon:  v. To avoid contact.  From the abbreviation for "no contact" used by
support groups (especially those dealing mostly with telephone enquiries).
"He keeps noconning me" implies that the other party is deliberately avoiding
your call.
%
noddy program:  n. A simple program to perform some basic function missing
from a larger program.  "I have written a Noddy program to display the time
the system was IPLed".  Named from the simple-minded hero of a popular series
of books for very young children (now banned in many educational
establishments, having been accused of promoting racism and other undesirable
practices).  Unlike properly designed and tested programs, Noddy programs
always work correctly.  (Sometimes also known as "back of an envelope"
programs, from the original source document.  They used to be written on the
back of punch cards until these were made obsolete by virtual cards.)
%
nodeid:  (node-eye-dee) n. The nickname under which a computer is known to
the rest of a network.  As for a userid, tradition and ancient lore dictates
that a nodeid should be made as cryptic, non-mnemonic and difficult to type
as possible, although some havens of sanity still survive (BOSTON, PALOALTO,
PARIS).  VENTA has the unique privilege of being mnemonic to Latin native
speakers.  [VENTA derives from Venta Belgarum, "Town of the Belgae", the
Roman name for Winchester, England.] See also vnetid.
%
non-concur:  v. To formally state that one will not support the action (such
as a product announcement) of another group.  The ultimate threat.  Makes any
project management quake - grown men have been seen to cry when threatened
with this.  This is an indication from one group to another that the first is
convinced that the second is about to cause a major disaster, and that
therefore the first group is prepared to escalate the matter as high as
necessary to resolve the problem.  See concern, issue, and the subtle
variation de-concur.
%
non-strategic:  adj.  Embarrassingly superior to that which is strategic.  It
is permissible to attribute defects to a non-strategic project even when
nothing is known about it.  In GBG (General Business Group) it used to be
automatically non-strategic to have a Big Blue solution to Office Systems
needs.
%
nonus:  (non-you-ess) adj.  Outside Domestic, especially when there is a
difference from the way things are done in the USA.  "That's a nonus issue -
not my problem".  This includes character sets, keyboard standards, national
languages, policies, politics, etc.  Although often pronounced "no-news", it
is rarely equivalent to "good news".  See also National Language Support.
%
noodle:  v. To think or ponder.  Often used to hint that there is no
politically comfortable solution, and a creative approach or a joke is
appropriate.  "Noodle on this overnight?" Probably a back-formation from the
colloquial noun meaning "head" (originally a blockhead or simpleton).
%
not obvious:  adj.  A publication editor's benign but illinformed re-wording
of transparent.  The classic usage was "The operation of the cache is not
obvious [rather than transparent] to the programmer".  This kind of rewording
tends to cause major riots in the programming halls.
%
notwork:  n. VNET, when failing to deliver.  Heavily used in 1988, when VNET
was converted from the old but trusty RSCS software to the new strategic
solution.  [To be fair, this did result in a sleeker, faster VNET in the end,
but at a considerable cost in material and in human terms.] See also
nyetwork, slugnet.
%
nucleus:  n. The inner part of an operating system; that part (usually) which
is immediately accessible.  As the atomic age matures, the term kernel is
becoming more popular.
%
null:  1.n. A pointer (storage address) that does not point to a real piece
of storage.  Often used to mark the end of a linked list of pieces of
storage.  The null pointer has different values (such as zero or -16777216)
depending on the application or language.  2.n. A character (of value zero)
that looks like a blank but is not a "real" blank.  A blank is real data,
originally entered by a person, that has value and should be preserved; nulls
are used to fill up areas on a mono-spaced screen that contain no real data.
%
nums:  n. Short for "Numbers".  Salesmen, branch managers, region managers
and sometimes even division presidents consider nums their end that justifies
any means.  Represents the quotas arbitrarily derived at the beginning of a
year to motivate the aforementioned people.  To "make the nums" is to make
quota or (if spoken enthusiastically with gestures of the face - wriggles of
the mouth and the eyebrows) to surpass it.  It may display the speaker's
envy.
%
nybble:  n. A group of 4 binary digits (Bits) which make up a single
hexadecimal digit.  Four bits is half a byte, so "nybble" seems an
appropriate term for this unit.  Also sometimes spelled nibble.
%
nyetwork:  n. A variation of notwork.
%
obsolete:  v. To make obsolete.  Commonly found in the text of edition
notices in books, as in "This major revision obsoletes GHXX-XXXX".
%
offering:  n. A product release.  As in "The next offering will have that
feature".
%
offline:  1. adj.  Not online.  2. adv.  Later, in private.  From the state
(not on-line) of a piece of computer equipment not connected directly to the
processor for one reason or another.  As in "Let's take that offline".  Used
by speakers when a question has been asked and a) the speaker does not know
the answer; or b) the speaker has a detailed answer which is probably not of
interest to most of the audience; or c) the speaker does know the answer, and
it is of interest, but does not want to give it in public.
%
offsite meeting:  n. A meeting not held at an IBM site (location).  Meetings
are held offsite either for pragmatic reasons or for effect.
%
old iron:  n. Obsolete IBM equipment, as seen by marketing.  In customers'
shops, it is barely obsolescent; within IBM internal functions (except
marketing demonstration centres) it hasn't even been installed yet.  This was
applied particularly to the 3277 Visual Display Unit (single-colour, but
still unsurpassed for speed of alphanumeric display - but not information
transfer - to the user); in IBM UK it used to be traditional to have a
mixture of these with English and American keyboards, usually connected to
the wrong display control units.  But today 3277s are truly old iron.  See
also iron.
%
one-line fix:  n. A change to a program that is so small it requires no
documentation before it crashes the system.  Usually "cured" by another
One-Line Fix.  See also I didn't change anything.
%
online:  adj.  Of some peripheral device (printer, tape drive, etc.)
connected to, attached to, or controlled by a computer (usually a mainframe).
See also offline, vary.
%
open door:  v. To skip one or more levels of management, usually to force the
resolution of some grievance.  From the "Open Door" programme that allows any
employee to escalate a grievance, even up to the Chief Executive Officer if
necessary.  Usage "I'll open door him if he blocks my move again".  See also
Speak Up!.
%
open switch:  n. An unresolved issue.  Usage "Whether we do that or not is
still an open switch".
%
opportunity:  1.n. A menial task that your manager wants you to do, or a
difficult or undesirable assignment.  As in "I have an opportunity for you".
Often used in the phrase opportunity to excel.  2.n. Problem.  "This company
doesn't have Problems, it has Opportunities".  An opportunity can be a little
more positive or optimistic than a simple problem, or if especially large and
intractable may be described as an insurmountable opportunity See also
challenge.
%
orange box:  v. An IBM telephone switching system, developed by the ROLM
Division of the corporation (sold to Siemens in 1989).  From the ROLM CBX II,
8000 or 9000.  The switching system in production before the October 1987
announcement of the IBM 9750 (which is cream white).  See also ROLMan.
%
organic debugging:  n. A euphemism for some fashionable techniques for
"improving" the Quality of software.  Reportedly, the output from a
compilation or assembly of the suspect program is placed on the floor, with a
large flat dish on top of it, and an indoor plant in a pot is placed in the
centre of the dish.  The dish is then filled with water.  The principle is
that any bugs in the program will be attracted towards the house plant and
drown as they try to cross the intervening water.  From statistical evidence
this seems about as effective a technique as many others currently in use.
It is hypothesised that the technique would be even more effective if the
house plant were first marinated in Kirsch (branntwein), but of course it has
been impossible to test this on IBM Domestic (USA) premises.
%
out-plan:  adj.  Of a task desirable but planned not to be done.  In general
Whatever it is that you want to be in-plan.
%
outredalle:  (ootreuh-dahl) n. For EMEA HQ people, the IBM France
headquarters; for IBM France HQ people, the EMEA headquarters.  The wide
plaza at the centre of the Defense district in Paris is known as "la dalle"
(a dalle is a flat stone used in floors, or, in modern architecture, any flat
and horizontal piece of concrete of sufficient dimensions).  The EMEA HQ in
Tour Pascal and the IBM France HQ in Tour Descartes are located on opposite
sides of the plaza, and therefore anybody going from one tower to the other
goes across (outre-) the "dalle".
%
outside awareness:  n. A window.  Some IBM offices and (especially)
laboratories are totally lacking in windows, but at last someone has noticed
that people work better if they can see the rest of the world, so new offices
are now sometimes specified to have outside awareness.  This radical concept
(that programmers require at least 3 hours of direct sunlight every day or
their hexadecimals cease to function) is not universal.  In Poughkeepsie and
Yorktown, engineers are not allowed to see the light.  As a reflection of
this, a number of signs (with a variety of creative artwork) have appeared on
the walls.  They usually state some variation on the theme "I must be a
mushroom, because they keep me in the dark, and feed me lots of horse
manure".  [Of all the world, only IBM employees know less about IBM than
journalists.] See Moletown.
%
overflow:  n. A connection that could not be made automatically.  A
printed-circuit card has a limited capacity for connection, determined by the
number of channels for wires between connection points and by the number of
vias available.  For a complex card, it is not possible to embed all the
desired connections.  Those connections that could not be included in the
printed wiring are called overflows, and are connected manually using yellow
wires.
%
own:  1. v. To have responsibility for, and some degree of control over, a
product, project, or data.  See owner.  2. v. To have responsibility for, but
almost no control over, the security of a data processing entity, such as
one's personal userid.
%
owner:  n. The person (usually a manager, and by extension his or her
department), who is responsible for the development or maintenance of a
product.  Formally, the owner is always a manager; in practice, ownership and
some responsibility are delegated to whoever is actually doing the work.
Documentation is unusual in that it often has two owners, the book owner and
the technical owner (who owns the product being documented).
%
pack rat:  n. A person who keeps immense numbers of ancient programs around
[presumably on a disk, rather than in a den] just in case they may prove
useful.
%
padded cell:  n. A program that limits its user to a finite, and usually
small, subset of the capabilities of the computer on which it runs.  This is
intended to save the user from injury (to person or to pride), or to save the
computer or data from damage by the user.  Also padded cell environment.
%
page printer:  n. A printer that prints a whole page at a time, with the
ability to represent printers' proportionally-spaced fonts and (usually)
illustrations.  The IBM version of "APA (all-points-addressable) printer".
Note that printers that use datastreams not invented by IBM are not Page
Printers.
%
paged out:  adj.  Not paying attention, distracted.  "What did you say?  I'm
sorry - I was paged out".  Refers to the state of a task in a multi-tasking
system whose storage chunks (pages) have been moved out of the computer onto
some other kind of storage, such as disks.  The program is just not all
there.
%
pain in the net:  n. A person whose primary activity seems to be bothering
others by sending them netrash, either directly or via a service machine.
%
panoota:  1. v. To guess or estimate.  From IBM Australia; the abbreviation
of Pull A Number Out Of The Air.  As in "Let me panoota a figure for you".
2. adj.  Estimated or guessed.  "It's a panoota number".
%
paper chase:  n. An officially sanctioned version of the infamous chain
letter.  (Also paper game.) For example, person A sends a letter to person B,
copying persons C and D. Persons B, C as well as D may reply, copying each
other and incidentally persons E, F, G, H and I. Person A, in self-defence,
responds to all, this time via a distribution list including persons B
through I and anyone else he can think of who might be remotely interested.
The next step is usually a meeting, to which the persons on the distribution
list each invite one or more members of their respective departments.  The
process usually runs down when the list of players gets so large that the
secretary or program attempting to book the meetings that follow cannot find
a time-slot acceptable to all.
%
parallel:  adj.  On a similar path, drawn using a jagged edge, and only
slightly divergent from some other path.  Usage "The new documentation will
be consistent with and parallel to the existing documentation".  See also
transparent.
%
paren:  1.n. Short form of "parenthesis".  Many people have forgotten that
"parenthesis" is the real word.  CMS users seldom bother to balance them; and
many userwritten CMS programs report the presence of a closing right
parenthesis as an error.  2.n. The character "("; used in conversation to
pair with thesis.  For example, the string "A(B)" might be described as "A
paren B thesis".  Especially favoured by LISP programmers, burdened by many
such.  See also banana.
%
parity bit:  n. An extra bit kept in parallel with each byte of memory in the
storage of most IBM computers (even [nearly all] PCs).  This parity bit
states the parity of the remaining eight bits, and so gives a high
probability of detecting an error in any given storage location.  Of course,
it also adds 12.5% more memory that may fail, and somehow it often does seem
that only parity bit memory chips fail.
%
parm:  (parm) n. Misspelt abbreviation of the word "Parameter", a variable
argument to a program.  This is used so universally that "param" sounds
silly.
%
part number:  1.n. The IBM catalogue number of a spare or replacement part.
2.n. Where English is not the native language, an item which has a part
number in an IBM catalogue.  You can be asked for or given a "numero de part
number" (part-number number).  This sense applies only to non-native English
speakers.  First heard from one of the Essonnes plant managers, but since
also from FEs and other people from various European countries.  See also
product number, model number.
%
partitioned:  adj.  Separated, broken.  As in "When the transatlantic links
are down, VNET becomes partitioned".  Here, the distinction between "broken"
and "partitioned" varies depending on the time of day and whether you are
east or west of the partition.  [Fog in Channel Continent cut off.]
%
passthrough:  n. Any of a variety of methods by which one computer which is
receiving messages from a terminal passes them on to a second computer as
though the terminal were directly connected to it (and similarly relays
messages coming in the opposite direction).  Also spelt passthru, from the
name of one such program.  Passthrough requires a program in the first
computer to pretend to be a terminal.  Having to write such a program is very
helpful in making computer buffs experience something of the effect of their
work on real people, but sadly the architects and planners who design the
data streams never have to dirty their hands and write one.  By implication,
passthrough is used from small computers to larger ones, or between peers.
Hence reverse passthrough is used when a large mainframe computer is used to
provide access to a much smaller machine.
%
patch:  1.n. A fix applied to a program by adding new machine code in an
otherwise empty area (often provided specifically for this purpose).
Applying a patch was often much quicker than rebuilding the program from
source.  2. v. To fix a program.  Often implies a "quick and dirty" fix.  See
also zap.
%
path:  1.n. The sequence of hops followed by a file sent from one node to
another.  The path may appear very strange, at times, since it is chosen
according to prevalent link speeds and traffic, rather than on purely
geographical constraints.  For instance, files have been seen transferred
from Kingston to Endicott (both in New York State) via Santa Teresa (in
California), and there is one report of files going from Hursley to
Portsmouth (both in Hampshire) via Poughkeepsie (New York).  2.n. The
channel(s) used by a mainframe to access its peripherals.  3. n. The order of
search used by an operating system to locate a program or piece of data.  See
also dual-path.
%
pay for the coffee:  v. To suffer mild pressure.  Said to originate from an
occasion when a manager, not known for his intra-personal skills or
generosity, bought one of his employees a coffee.  The employee, surprised,
politely thanked the man and headed back to his desk, only to find he had
been followed and was now being confronted with a work-related problem.
"Sure," he quipped, "now you're going to make me pay for this coffee.."..
See also tanstaafl.
%
peer review:  n. An approval process whereby a design or product is reviewed
by the technical peers of the designer or design group.  When treated
responsibly this is a powerful and effective technique, but all too often it
becomes a political skirmish.  In this latter case it becomes a game with
many players on one side and usually few on the other.  The object is for the
side with many players to inundate the opposing group (the "peers") with so
many facts and figures about the goodness of the design being reviewed, that
the second group must just nod in agreement or run the risk of appearing
stupid.  When played successfully, the members of the second group dare not
ask for additional information for fear of being told they had already seen
it in presentation form.
%
pel:  n. Picture Element.  One addressable point on a display screen or
printed sheet of paper.  This is used as a convenient abbreviation (far more
logical and easier to say than "pixel"), and also as a measure of screen or
printer resolution, as in "16 pels per mm (16ppmm)".
%
penalty box:  1.n. A position of low esteem.  This term probably derives from
Ice Hockey, in which rulebreakers may be required to sit out of the game (in
an area called the penalty box) for some specified period of time.  Thus,
when an executive is transferred from a position of power to one of less
power, perhaps after having been associated with a failed project, this may
be described as "going to the penalty box".  Favoured penalty boxes are
Research (see sandbox), Group Staff, Quality Coordinator, or Branch Manager
of a remote or moribund location.  Another technique is to keep the offender
at the same location, but put him or her in charge of a less exotic project
(e.g., "Productivity" or "Standards").  Variation "He got five years for
fighting".  See also walk in the woods.  2.n. The OS/2 compatibility box.
%
penguin:  n. An affectionate term for a member of a Field Support team, when
used by Laboratory personnel.  Field Support people in some areas wear white
shirts, dark suits, and a formal attitude.  It's also said that they often
walk with a side to side gait (waddle) caused by carrying a tool kit in one
hand and an oscilloscope in the other in their Customer Engineer days.
%
peon:  n. A person with no special privileges on a computer system.  "I can't
force a new password for you, I'm only a peon on this system".
%
people:  n. Non-managers, as in "Only first-line managers deal with people,
in IBM".  Higher-level managers, it follows, do not deal with people.  (Who
or what do they deal with?)
%
perfect programmer syndrome:  n. Arrogance.  "Since my program is right,
there is no need to test it".  Or "Yes, I can see there may be a problem
here, but I'll never type SHUTDOWN on the RSCS console when there is a CP
read up".  [This latter action had the unfortunate side-effect of closing
down the entire system, instead of just the communication subsystem (RSCS) if
the CP privilege class assigned was too high.]
%
performance release:  n. A release of a product or internal program put
together (usually in a hurry) when it becomes apparent that the previous
release was too slow or used too much resource.  A performance release should
show improvements in performance without loss of function.
%
permanent home:  n. Any IBM building or office in which you will reside for
less than one year.
%
permanent move:  n. temporary assignment.
%
permanent recording:  n. The only data that remains on a disk after a head
crash.  Readable only by one or two gurus in San Jose.
%
person-month:  n. A fashionable term for man-month.
%
personal computer:  1.n. Before 12 August 1981 a computer used by one person,
who is local to it and does not time-share it.  A catch-all for home
computers, hobby computers, the 5100 APL-based machine, professional
workstations, some 3031s, and probably a few Cray-1s.  2.n. After 12 August
1981 the IBM 5150, 5160, 6150, etc.  This has had the predicted major impact
on the industry, and an even bigger impact on IBM itself.  3. n. A way to
continue business work at home.  4. n. A way to continue game playing when at
work.  See PC.
%
personalize:  v. To program.  As in "Let's personalize the gate arrays
tomorrow".  See burn sand.
%
perturbate:  v. To perturb.  To cause an undesirable change, usually in a
budget or a schedule.  Used chiefly by Aerospace Engineer types who have
joined IBM some time into their careers.  "Joe, how much is this going to
perturbate your launch schedule?" [This is the same strange modification to
usual English as in the constructions "orientate", "preventative", and
"indentate".  I suppose that they do help sell storage devices.] See also
hit.
%
pick-and-pray:  n. A multi-choice question in an exercise or test.
%
pig iron:  n. Any very large, very fast, mainframe computer (equivalent in
cost to a 5 MIPS mainframe in 1982).  Used as "Sure that software is slow,
but it will sell a lot of pig iron that way".  See also rusty iron, micro
iron, push iron.
%
pistol:  n. A program whose protection features (if it has any) make it very
easy for you to shoot yourself in the foot.  Usage "The DOS COPY command is
such a nice pistol!"
%
pitch:  1.n. A presentation.  "Are you going to the Akers pitch in the
auditorium?" 2. v. To present, or attempt to persuade.  "Are you going to
pitch that to staff someday?"
%
pitcher:  n. A program that executes at a central site and distributes
[sends] programs and data to remote locations.  The term comes from a North
American game called "baseball".  See catcher.
%
placard a balais:  n. Broom cupboard.  The empty space in mainframes, often
used by CEs to store all kinds of tools and spare parts.  It is reported that
in civilised countries this space can advantageously be used for the storage
of beverages.  Sugary drinks, beer, Champagne, and white wine go near the
channel cable input to take advantage of the cold air intake by the cable
hole in the floor.  Red wines can be warmed to an appropriate temperature in
the power supply area.  A Domestic reader recalls the control unit for the
2305 drum, whose early models had a built-in compressor to cool them because
the forced roomtemperature air was not sufficient.  This had a space next to
the cooling coils that was just big enough to hold a six-pack [a retail unit
of six cans of beer].  At some military installations, where the rules on
beer were less strict than at civilian installations, the operations staff
were wont to share an IBM-cooled can or two with visitors.
%
plan of record:  n. Plan.  A plan of record has by implication extra solidity
- though in fact it is the least reliable plan of all, since product plans
always change.  Caution dictates that any figures or targets in a plan of
record, once committed to paper, will not be sufficiently "aggressive".  Each
level of management therefore inflates such figures before passing the plan
up the chain, until it reaches the final authority - who sets the numbers or
target according to some preconceived notion.  See also action plan, whim of
record.
%
planar:  n. A large printed circuit card onto or into which other cards are
plugged.  Known as a "Motherboard" by users of cruder imagery.
%
planification:  n. Planning [one must suppose].  As in "This software
qualification tool allows the conception, maintenance, planification and
execution of sequence tests".
%
planned personal illness:  n. A minor illness, serious enough to require
absence from work, which the victim seems to know about several days in
advance.  Mostly taken by people who are rarely ill and who feel that they
are "entitled" to their fair share of time off.
%
planner:  n. One whose job is to think about doing real work.
%
planners' droop:  n. A chronic symptom demonstrated by most forecast graphs.
It describes the tendency of revenue projection graphs for a given product to
show a steep rise for the next 3 years followed by a steep decline.  Since
falling graphs are anathema to any selfrespecting planner, the situation is
usually remedied by postulating a gap product which will appear in 3 years
and keep the revenue graph going upwards.  This has the added advantage that
the product manager has a superb excuse to explain his need for a further
cast of thousands to develop this (hypothetical) product.
%
plant life:  n. One who works in a manufacturing plant (rather than in a
sales or development area).
%
platform:  n. A collection of machines, often of the same hardware
architecture, or a family of operating systems or software interfaces.  Usage
"We'll build the new cellar management application on a PS/2 platform", or
"The communications help facility will be based on an AIX platform".
%
play:  v. To spend one's own time on a project.  As in "I'm staying this
evening to play with the new Fred program".  It seems that most really usable
software, a surprising amount of revenue, and even more profit, derives from
such "play".
%
play pen:  n. A room where programmers work.
%
plist:  (pee-list) n. Parameter list.  A programming mechanism for passing
arguments (parameters) from one environment or program to another.
%
point:  n. A measurement of the IBM list price of a product, originally
equivalent to a monthly rental of one U.S. dollar.  See also funny money.
%
pointing device:  n. A mouse or light pen.
%
polysyllabic:  n. Any word of two or more syllables, although in IBM a
minimum of four is preferred.  "IBM conventional methodology involves the
utilisation of polysyllabic utterances to the maximal degree", especially in
documents for announcements.  Polysyllabics are also popular in product
proposals because they make life harder for the reviewers the documents take
longer to read, the authors' meaning is less clear and therefore harder to
refute, and they discourage any comments from foreign IBM laboratories.  In
skilled hands, the technique can even be used successfully between British
and American English speakers.  Example "CICS/VS offers a functionally
superior alternative to CICS-Standard" is longer, more dazzling, and less
clear than "CICS/VS works better than CICS-Standard".  After all, it might
not actually work at all.
%
pony:  n. Something good that may (hopefully) come out of a bad situation.
This refers to an apocryphal story about a hopelessly optimistic boy who was
given a barn full of horse manure by his father on his birthday.  He
immediately grabbed a shovel and started to dig, while chanting "There must
be a pony in here somewhere!" Anything is possible if you have Faith.
%
port:  1. v. To move a program from one computer to another - and get it to
work in the new environment.  If it is said that a program is "portable", it
is intended to convey the fanciful notion that the program can easily be made
to run on a foreign hardware or software architecture.  Ease of porting a
program is highly dependent on the porter's point of view, increasing in
proportion to one's distance from actually working on the problem.  2.n. A
hardware interface between a computer (usually a small one) and some
peripheral hardware such as a network or keyboard.  "The mouse is attached to
port 7".  [Poor mouse.]
%
position:  1. v. To explain or provide context to.  As in "Let me position
you on that subject".  2. v. To describe by providing context.  As in "Would
you first position XXX for us?"
%
pound sign:  1.n. A name for the symbol "#" (two horizontal lines crossed by
two vertical lines).  This nomenclature is used in some (but not all) areas
of the USA; elsewhere the symbol is known as "the number sign", "the
octothorpe", or simply as "hash" or occasionally "hatch").  The musically
inclined call it a "sharp", but a convenient way of describing it is "the
tic-tac-toe board", or "the noughts and crosses board" (depending on one's
heritage).  2.n. The name most often used for the British (Sterling) currency
symbol.  This is an antique capital L (standing for libra, the Latin for
"pound"), a cursive "L" crossed horizontally by one or two small dashes.
Unfortunately it cannot be illustrated here because of the unpredictability
of printing devices.  See currency symbols.
%
power cycle:  v. To reset, by removing and then restoring the power to a
machine.  See Poughkeepsie reset.
%
power eraser dispenser:  n. The ultimate unnecessary feature.  See bells and
whistles.
%
power suit:  n. The wardrobe worn by the movers and shakers within an
organisation.  This (for a man - women dress more subtly) consists of a dark
blue threepiece pin-striped suit, a long-sleeved white shirt, the latest in
tie design (in 1985 that was a striped tie with the stripes pointing to the
left shoulder), a black belt with an inconspicuous buckle, thigh-high socks
with colour matching belt and shoes, and black wing-tip shoes.  In Texas
genuine lizard [or other unconservational leather] cowboy boots may be
substituted for the wing-tip shoes.  In 1983 blow-dried hair styles and
moustaches were also necessary.
%
power up:  v. To switch on.  Usually applied when the switch-on process is
complex or involves a number of machines.  "Could you power up the system if
you're the first in on Sunday?" See also up.
%
prayer meeting:  n. A meeting, usually of a task force that is hoping for a
miracle to solve some intractable problem.  As in "The Performance prayer
meeting starts at Two".
%
preannounce:  v. To announce something (usually a product) before it has been
formally approved for announcement.
%
precurse:  1. v. To precede in the manner of a precursor; to act as a
forerunner or harbinger of an advancing technical evolution.  As in "It is
for us to precurse that technology for the rest of the corporation".  See
also leading-edge.  2. v. To offer a brief incantation prior to divulging an
innovative solution to a problem.  e.g., "May the fleas of a thousand
diseased camels inhabit your armpits".  See NIH.
%
price/performance:  n. An undefined measure of valuefor-money.  As in "The
XYZ offer improved price/performance".
%
priority list:  n. A dynamic list of things to do, sometimes in a Virtual
state, to which is attached a priority pertaining to each item, ranging from
"right away" to "probably never".  Usage "I'll put that on my priority list".
It is recommended that if you are on the receiving end of this statement, you
should obtain at least an approximate date of completion.  This date, of
course, you will remember as a definite commitment.  See also time-frame,
virtual, wishlist.
%
proactive:  adj.  Active, not reactive.  Used of people or policies that take
the initiative rather than result in interrupt mode activity.  It is also
sometimes applied with the sense of "teaching" or "reaching out".
%
problem state:  n. Doing something for someone else.  The System/360 (and
370) architecture recognises two basic "states".  One is "Supervisor State",
in which the machine is doing work for the supervisor - usually an operating
system; and the other is "Problem State", in which the machine is
conceptually solving problems for the user.  [This is a rather narrow view of
the System/370 world, however, as (for example) the VM/SP product makes both
states accessible to the user by a little "sleight of virtual machine".]
%
product number:  n. The four digit number that identifies every major IBM
hardware product.  The numbers rarely have any relationship to each other but
sometimes some sort of sequence may be followed (e.g., 3350, 3370, 3380 are
all disk storage devices).  See also model, part number.
%
product tester:  n. Someone who tests products.  Those who have been to the
mountain; keepers of the word; interpreters of the Specifications.  Sometimes
disliked by developers, these were the people that really did assure that
products were high quality before their mission was changed and they became
paper-pushers [through no fault of their own].  Research has shown that most
were given chemistry sets or electronic kits at an impressionable age by well
meaning parents.
%
production program:  1.n. An application program.  This term dates from the
days when computers rarely had operating systems, and instead ran just one
program at a time, loaded by the boot program.  If the program did (or
appeared to do) something of value, it was called a production program.  2.n.
Any program no longer undergoing testing and thought to be safely
operational.
%
production system:  1.n. floor system.  2.n. The version of the operating
system that you get when you don't do anything special (don't take any
risks).  This is usually the system being used by the people who are sitting
around at terminals and actually being productive.
%
productize:  v. To give an unfinished piece of software or hardware the
appearance and form of a finished product.  As in "Productization is taking
place on all levels" [sigh].
%
professional:  n. An employee who is not a manager.  "Our professionals are
the best in the business".  Often used as an euphemism for "technician".
%
professors:  n. The staff of the IBM Israel Scientific Centre, at Haifa.  A
mildly derogatory term used by marketing people in Israel that also implies a
grudging respect; a remarkably high proportion of that staff are indeed
professors.
%
program manager:  n. A person who is a manager of a project or product but
who (by design) has no employees reporting to him or her.  See also
card-holding manager.
%
programmer:  n. A machine for converting ideas into practice.
%
programming:  n. The art of debugging a blank sheet of paper.
%
progress:  v. To make progress with arranging.  As in "We are progressing
your promotion".  (Use Rare.)
%
proof:  v. To run a spelling checker program against a document.  From the VM
program called PROOF.  Mainly used, in the UK, to check documents before
sending them to readers in the USA who are sensitive to British spelling.
%
protocol:  n. A sequence of events or exchanges of information defined to
enable two machines or programs to communicate with each other.  This bears
slight relationship to the usual senses of this word, but does correctly
convey the flavours of solemnity and complexity that are associated with such
communication.
%
prototype:  1.n. The first implementation of some idea in the form originally
envisioned for it by the original innovator.  Generally unrelated in form,
function, and cost to the final production version.  2. v. a) To implement a
working system fast, i.e., by "unconventional" methods.  b) To implement a
"model" system that has to be replaced by a "proper" system later [lest
anyone realise how simple programming is].
%
pubs:  1.n. The Publications (now "Information Development") department of a
Development Laboratory.  2.n. The publications (manuals, books, and
brochures) associated with a hardware or software product.  See fix it in
pubs.  3. n. The name of a program that provides a user interface to the
ProcessMaster product.  "I'm a fulltime PUBS user now!"
%
pulse:  n. A temporary change in the level of a logic signal.  It is
difficult, nowadays, to observe the very short pulses in fast computers with
ordinary electronic equipment such as oscilloscopes - the capacitance of the
leads connecting the oscilloscope to the computer will degrade and sometimes
destroy the information in the signal being inspected.  A story from the
not-so-recent days of 3033 development is related by an engineer who looked
over the shoulder of his colleague and commented "That's a mighty noisy line,
Joe".  Joe looked up and replied "Them's good bits, Ken".  The bits were
seven nano-seconds wide.  A pulse that is in the wrong place (and, usually,
is shorter than an intentional one) is known as a glitch.
%
punch:  v. To transmit data electronically from one disk pack to another.
Often these disk packs can be around the world from one another but just as
often can be the exact same one.  A VM/370 term, from the use of a virtual
card punch to send data from one virtual machine to [the virtual reader of]
another.  Usage "Punch me that jargon file".
%
purple wire:  n. The wire shipped with a feature change to the IBM 1130 and
1800 Systems.  Also referred to as personality wire.  Used and required to
tell the software about the hardware installed on a system, and its address.
A change here is Most Frightening to the "Sensor based" Customer Engineer.
See also yellow wire, blue wire.
%
push iron:  v. To make a living by selling hardware.  Formerly referred to
those salespersons who sold only large mainframe computers.  Also pump iron.
See also pig iron.
%
put a stake in the ground:  v. To stabilize a fluid or confused situation.
For example, to provide a focus or leader for a group effort.  Also put a
stake in the grid.
%
put in place:  v. To complete.  As in "Do you have the plan of record put in
place yet?"
%
puzzle palace:  n. A building in which the computer room has expanded beyond
its original boundaries.  Buildings 701, 920, and 921 in Poughkeepsie are
prime examples some aisles dead-end at a printer box-room, and then resume on
the other side of the room.  This may be adapted from a favoured nickname for
the NSA (National Security Agency) in the USA.
%
qfoic:  (queue-foe-ic) v. To display or update the microcode configuration on
a 43xx computer.  This name comes from the "fast-path" incantation used to
access the menu for changing UCWs (Unit Control Words).
%
quad:  n. The character formed of a simple rectangle of lines, used in the
APL language for various mysterious purposes.  Conjures up memories of
glorious University afternoons to many.
%
qualified:  adj.  Of a part (piece of hardware) tested six ways from Monday
(sic) and approved for use in IBM products.  Generally a well known product
(such as a TTL "7400" quadruple NAND) whose identity is subsequently
disguised behind a twelve-digit IBM part number.  Since the original part
number is no longer available, the only specifications available are those
produced by the Fishkill testing lab - which tend to give no hint of what the
part really is.
%
quarter:  1.n. A three-month portion of a year.  The unit of time used when a
"month" is too precise, as in "We will announce in 2Q88" [second quarter,
1988].  half is sometimes used, in a similar manner, when plans are even less
definite.  2.n. A quarter of a byte (half a nybble).  Also two bits - a
reference to the old coins which broke apart to make change, the pirate's
Pieces of Eight.  [This isn't in very common usage, but the incestuous puns
may please.]
%
quick and dirty:  adj.  Of software or hardware produced in a hurry to meet
an urgent request or to fix a problem, usually someone else's.  One's own
solution is usually a prototype.  Also used to imply inferiority, or to defer
a simple request from an end user, as in "I can give you a quick and dirty
solution in four weeks [which will do exactly what you want] but a real
solution [which will do exactly what I want] will take eight months".
%
quiesce:  v. To halt after finishing the current task.  This term is often
used to describe the process of stopping the flow of data across a network
link, or to some device such as a printer, so that maintenance of some kind
can be done.  As in "We're quiescing the link now; you can have the machine
as soon as that last file is through".
%
racheck:  (rack-check) n. The RACF security system's primary macro call to
check authorisation of an action; often used as a verb.  In technical usage
this term is neither good nor bad, and just indicates a place where RACF will
check for authority.  In common usage, it means access that (apparently
capriciously) is denied; as in "I could have finished that project last night
but I got rachecked so many times I gave up".
%
raft:  1.n. A collection of programming ideas, loosely bound together and
floated as a suggestion for a new software release.  As in "We are proposing
a 15K raft of improvements".  In a streamlined development process there can
be a close resemblance between the raft and the First Customer Ship (FCS).
[Though it may surprise you that anyone could confuse a raft and a ship.] 2.
v. To put forward as a suggestion.  "Let's raft that at the meeting
tomorrow".  3. n. Something flat, untidy and of practical use only to its
designer.
%
rainbow book:  n. Nickname for GH09-0242 The Nature of Office Systems, a
document, distributed to thousands of customers in 1984-6, that chronicled
IBM Canada's experiences in installing Office Systems.  So called because of
the photograph of a rainbow over the Rocky Mountains on the otherwise black
cover.
%
raindance:  n. A complicated sequence of steps (including some physical
activity), required to achieve some goal.  It may include a few incantations
as well as more tangible actions (such as mounting tapes, flicking switches,
etc.).
%
raised floor:  n. An area where a large computer installation can be found.
Named because the computers stand on a false floor which is elevated some
distance above the "real" floor of the building, in order to leave space for
the boas to prowl.  Usage "We can put that in the raised floor", or "Site
XXXX will be down Memorial Day weekend.  This will include system YYYY also
since it is on the raised floor that will be down".
%
ramp:  v. To increase.  From the A/FE Corporate News Letter, 31 May 1985 Q.
"What's the latest update on PC/AT delivery shipments?  Are you still
encountering supply shortages?" - A. "Demand for the AT has exceeded our
expectations, although we are ramping up production of enhanced AT's with
additional fixed drive sources".  The reader is referred to the Concise
Oxford Dictionary for some alternative definitions of "ramp" that may be
appropriate in some circumstances.
%
rat belt:  n. A cable tie.  Small cable ties are mouse belts.
%
rattle some cages:  v. To do things, (writing memos, making phone calls,
sending VNET messages, etc.) that will make someone unhappy.  Generally done
because they have made you unhappy.  "I'm going to rattle some cages and see
if I can get this spec changed".
%
reach-around:  n. Communication which does not just go up the management
chain or down it, but rather goes up the chain and then returns directly to
the original level as a response.  Use extremely rare.
%
read:  v. To move data from one real or virtual disk pack on your system to
another.  A VM/370 term, derived from the READCARD command that was used to
move virtual cards from the virtual card reader to a virtual disk.  Usually
the source disk pack (the virtual reader) is owned by the spool system and
the destination disk pack is dedicated to a user.  Usage "Please read that
new file onto your disk".  See also receive.
%
reader:  n. A temporary place on a disk pack to place data until a user
decides exactly what to do with it, or it is destroyed by a cold start.  From
"virtual card reader".  Also used as a place on a disk pack where one user
puts data so that another user has a good chance of finding it, and as a
system-owned area of space to store data if your private space allocation is
not large enough.  See also read.
%
reader eater:  n. A computer program that automatically processes the files
in a reader.  Typically used to discard unwanted messages and to maintain
private copies of forums.  It may be coincidence that "reader" and "eater"
rhyme in the speech of many North Americans.
%
real IBM:  n. That portion of IBM which is not part of the Research Division.
Used in the Research Division.  See also real life.
%
real estate:  n. A resource of some kind that is both physical and
two-dimensional.  Examples a) A small area of land purchased to build
facilities for creating things; b) A large area of land purchased to build
bigger facilities for administering the facilities for creating things; c)
That area of floor space in a machine room that is just too small for the new
machine that you need; d) That area of a desktop that is too full of other
things to permit the siting of a terminal in a convenient position (see also
footprint); e) That area of a silicon chip which is too small to permit the
incorporation of the function required to make the chip useful.
%
real life:  n. The field.  Used by people consigned or resigned to working in
Headquarters locations, as in "He's probably right, he just came from real
life".  See also real IBM.
%
real money:  n. See blue money.
%
real storage:  1.n. The main storage in a computer.  This term widely
replaced "core" when the latter term became out-dated.  For example, "This
machine has 8 MB real storage", meaning 8 Megabytes of (physical) main
storage.  2.n. Hardware (physical) storage in contrast to virtual (imaginary)
storage.  This term was precise in the days of early System/370 computers,
which could only have one processing unit.  3. n. An imaginary representation
of the physical storage of a computer.  This sense of the term was necessary
for the multiprocessing System/370, such as the 158MP and 168MP models.  Here
there could be more physical storage than (in theory) the processors could
address.  Increased performance was possible by providing each processor with
its own bank of real storage (here called absolute storage to minimise or
maximise confusion).
%
reality check:  n. A comparison between an idealistic point of view and a
pragmatic point of view.  Employed when design groups come up for fresh air
(or peer review) when deliberating alternatives for new features.  See also
sanity check.
%
rearrange deck chairs on the Titanic:  v. To perform pointless actions; a
description for frantic, useless endeavours in the face of an impending
disaster.  This derives from IBM Canada, where it was applied to measures
designed to head off a slipped ship date.
%
receive:  v. To initiate the movement of a file from the spool system onto a
private disk.  As in "When you get the file in your reader, please receive
it".  Derived from the name of the program used to move the file.  See read.
%
recognition event:  n. A gathering to which employees may be invited as a
reward for their achievements.  Awards may be presented, or some of the
activities may be simply entertaining or not directly productive.  Usage "We
proposed holding the Technical Forum at a non-IBM site near the ocean, but
rescheduled to Dallas so it wouldn't be construed as a recognition event".
%
recurse:  v. To recur.  Not to be confused with the repeated invocation of a
spell or oath.  Almost certainly derived from the adjective recursive.
%
recursive:  adj.  Referring to itself.  See recursive.
%
recycle:  v. To bring a system down and then restart it.  Used especially for
whole systems ("recycle the 3081"), but also to a sub-system ("JES2 was
acting flaky, so I had them recycle it").
%
red layer:  n. Applications software.  See layer.
%
red line card:  n. A logic card not made to normal production standards, so
deemed not suitable for use in production machines.  Marked with a red line
which acts as a warning.  See also gold card.
%
redeploy:  n. A person from an IBM plant, laboratory, or HQ location who has
accepted a position in a marketing organisation.  As in "Debbie's a redeploy
from Poughkeepsie".
%
reference:  1.n. A document that is the ultimate source of information about
a piece of software or hardware.  To write a good reference is one of the
most difficult technical writing tasks.  Note that almost by definition a
reference is only useful when you already know something about the object in
question, and is often almost useless to a new user.  Usage "This document is
not a tutorial, it is a reference".  2.n. A cross-reference from one program
routine to another.  In general, a crossreference from one storage location
(address) to another.  3. v. To refer to.  The verb formed from "Reference
(2)".  As in "The allocate routine references HIGHMEM to find out how much
storage is available".  Also seen in documentation "You may also want to
reference the CMS Command and Macro Reference".
%
refresh:  n. A new copy of a (software) package.  Getting a refresh implies
that you are installing the whole package again as a precaution against
having missed some partial update in the past.  A package for which refreshes
will no longer be provided may be considered frozen.
%
regression bucket:  n. A set of test cases to run against a product during
development to check that things that used to work still do, or to allow the
measurement of any change in performance.  See also bucket, test bucket.
%
regular employee:  n. A fully benefited IBM employee.  Once upon a time
almost all employees enjoyed all privileges; nowadays a third of the
workforce in some countries are freelance, employed for a year or two at
most.
%
reinvent the wheel:  v. To do something that has already been done.  A
derogatory phrase, mainly used to prevent someone from writing a system
correctly now that he or she has become familiar, through experience, with
what should have been done in the past.
%
release:  n. The software prepared for shipment to customers.  All the code
that a development group has produced by some arbitrary date, sometimes
regardless of whether it works.
%
release-to-print:  n. A declaration, by a document's technical owner, that
the material is correct and complete and may be sent to the printer.
%
release x:  n. (Where x is some number larger than that of the current
release.) Never-never land.  "Well, that's a nice function - we'll put it in
Release 6".  Cynically implies that no Release 6 will take place.
%
remap:  n. A machine whose logic design has been entirely or largely taken
from an earlier machine and re-implemented in a newer (usually denser)
technology.  The 370/148 was a remap of the 370/145, for example.
%
rep:  1.n. Short for "Marketing Representative".  The rep is IBM's primary
contact with the customer.  IBM holds the rep responsible for the account,
hence the rep has nominal final say on everyone else's contact with the
customer.  An IBMer in a laboratory, for example, should usually only call a
customer with the rep's approval.  Unlike an SE (System Engineer), reps are
paid on commission and are seldom very technical.  2.n. An incurable (but
rich) optimist.  3. n. For systems, the lead account rep is the System
Architect, designing and assembling a system for the customer from the
various boxes and programs found in the Sales Manual.  If successful in
beating great odds doing this, a rep is rewarded handsomely by both cash and
company-sponsored trips.  If unsuccessful, he (or she) may just vanish like
Carroll's Cheshire Cat, which "disappeared quite slowly, beginning with the
end of the tail, and ending with the grin, which remained some time after the
rest of it had gone".  4. v. To directly alter the compiled version of a
program.  Derived from the "REP" (replace) command used in object code card
decks (such as system load, SuperZap, and System/360 object code decks).  See
also code, zap.
%
repository:  n. A cavernous storage area where data may be found.
Programmers in the 1970s spent many adventurous hours searching for the
repository; programmers in the 1980s spent even more hours creating a new
one.
%
repurpose:  v. To save some equipment from the scrapheap by, for example,
reprogramming it to do something useful.
%
requirement:  1.n. A feature that must be included in a product as otherwise
someone will non-concur.  Therefore, the best way to get a new feature into a
product is to persuade a third party to describe it as a requirement.
Conversely, it is very hard to get anything truly innovative into a product,
as (since no one else had thought of it) there can hardly be a requirement
for it.  2.n. A function or quality that must be included in a product, as
otherwise it will be considered unsaleable to some selection of end users.
%
resource:  1.n. Any commodity (usually in a computer system) that may be in
short supply (memory, CPU instruction cycles, etc.). A singularisation used
for effect, as in "If we try and run the printer and modem simultaneously,
we'll just run out of resource".  Use of this word also avoids committing
oneself to a statement of which of the (un)available resources will be the
limiting factor.  Also used as a euphemism for headcount, or [insultingly]
for an individual.  2. v. To allocate, or find, the resources needed for a
project.  Usage "How are we going to resource the follow-on?"
%
retread:  n. A Re-trainee - someone who has been trained to do a new job,
which is not necessarily his or her vocation.  Not a nice term.  For example,
it may refer to a planner or engineer who has become a programmer after 90
days of programming school.
%
retro-upgrade:  1. v. To apply appropriate correctional and preventive
maintenance to a software product (such as a System Control Program) that is
significantly outof-date and generally not of the same level for which the
maintenance was designed.  This takes place when a product that has been
functionally stabilized is suddenly seen to have new market potential.  2. v.
To change the base source for a new release of a software product (again,
usually a System Control Program) from that new release to an older release
(for purposes of upward compatibility).
%
retrofit:  1. v. To add a needed feature to a piece of software or hardware
rather later than it should have been added.  Usually results in inelegant
architecture.  2. v. To merge.  A standard procedure in some divisions
laboratories A and B work on a project independently for a time, then each
"retrofit" their updates to the other's work performed in the meantime.  A
sensitive political situation arises when one group's updates must be
"retrofitted" because of unexpected changes made to lower-level updates by
another group.  3. v. To adapt existing local modifications of a program
(usually an operating system) to fit a new release of the program.
%
reverse emulate:  v. To make an IBM computer or terminal behave as though it
were the equipment of a competitor.  This is considered to be retrograde,
akin to emulating a Volkswagen with a Porsche, hence the "reverse" modifier.
%
reversion:  (ree-version) v. To change the version number.  Usually a step
following a significant change or enhancement to a product.  "Can we reprice
without reversioning?"
%
revisit:  (ree-visit) v. Of a problem or issue to discuss again.  As in
"Well, we aren't going to solve that today; we'll have to revisit it in the
next meeting".
%
revival hour:  n. A weekly meeting with the purpose of getting Engineering
and Programming functions talking to each other.  The term is a reference to
the essentially "religious" (i.e., superstitious) nature of the discussions
that take place during these meetings.
%
road:  n. Used in NAD to signify anywhere that "action" takes place.  "Where
the rubber meets the road".  See also sky.
%
rococo:  adj.  Of a program or machine having many fancy frills and curlicues
that add no function.  A reference to the highly ornamental style of art
prevalent in Europe circa 1730-1780.  The word can also imply antiquity, in
the sense of "out-of-date".  Similar to bells and whistles.
%
roll out:  v. To deliver or announce a product or series of products.  As in
Rere's how we'll roll out the mid-range boxes".  Also rollout n. A delivery
schedule or plan.  "Can I see the rollout for the P and N series?"
%
roll your own:  1. adj.  Non-IBM, ad hoc.  This term is often used when
referring to a customer's software which was "home grown" but for which there
seems to be an equivalent IBM product.  e.g., "This customerruns a RYO
teleprocessing system".  2. adj.  Of IBM software self-tailored.  Typically
used to describe a system assembled and configured by the customer from a
selection of software components offered by IBM.
%
round and brown:  n. Magnetic storage, especially large and fast disks.  From
the iron oxide colour, and shape, of most magnetic disks [modern high-density
disks are no longer brown].  As in "storing data on the round and brown".
Also known as rusty memory.
%
rubber:  n. See road, sky.
%
rubber bands on wrists:  n. A sign of an old-timer.  Decks of cards were
often held together with a rubber band; so essential was this tool for
programmers that many kept a few conveniently sized bands constantly
available to hand [as it were].
%
rupt:  n. An interrupt.
%
rusty iron:  n. Out-of-date, hard-to-repair equipment that, when it works,
does the job better and cheaper than anything to be found in the current
sales manual.  (Especially true of non-IBM electrical or mechanical tools.)
See also pig iron, tired iron.
%
safe:  n. Any filing cabinet that has a combination lock (instead of a key
lock).  Also known as an "approved container", such a cabinet may be used for
the legal storage of USA Government classified documents.
%
salary plan:  n. A document rumoured to explain why managers get paid more
than technical personnel, and why employees in different countries get paid
different amounts for earning the same amount of revenue for the company.
%
sandbender:  n. A person directly involved with silicon lithography and the
physical design of chips.  Not to be confused with logic designers, most of
whom (it is said) would not recognise a transistor if they stepped on it with
bare feet.  [Possibly because it is more painful to step on a 14-pin
Dual-In-Line package than on a transistor?]
%
sandbox:  1.n. A location or department where the immediate goal is not a
product or product support (or where the goal should be a product, but isnt).
The Sandbox Division is the Research Division.  Almost always used in a
derogatory sense.  See also adtech, fun and games, trivial.  2.n. The
Washington Systems Center experimental laboratory.  So described in
authoritative presentations, and reflected in the node name WSCSNDBX
(officially "WSC Systems Networking Development BoX").  3. v. To prototype
something, to experiment.  As in "I can't tell you if that will work, now;
we'll have to sandbox it".  4. v. To spend time on a project or subject which
is of particular interest but is outside your area of responsibility,
especially when you had no intention of doing so.  As in"We went in to get
approval to repaint the cafeteria, but ended up sandboxing the merits of
intelligent workstations for two hours".  See also hobby.
%
sandwich file:  n. A spool file that contains more than one operating system
(logical) file.  Such a file provides one method of introducing unwanted or
undercover files into a system.
%
sanity check:  n. A second, pragmatic, opinion or estimate.  "Let's
recalculate that as a sanity check".  Also used in the sense of informal
verification, "Are you still there?  Does this address still work?" See also
reality check.
%
sardine can:  n. The small square metallic package used for many IBM chips
over the years.  Vendor chips usually come in plastic or ceramic packages.
Also Burlington sardine can.
%
scaffold:  v. To provide temporary layers of software either at a higher or
at a lower level than a routine to be tested, in order to simulate the normal
conditions of use.  "You'll have to scaffold that code if you expect us to
test it in August".
%
scalarize:  v. To turn good APL into bad APL (by removing all vector and
matrix operations) for the purpose of translating it to bad FORTRAN [or ADA].
The bad FORTRAN is then manually translated into (hopefully) good FORTRAN.
It is often faster to prototype a function in APL, scalarize it, and then
translate it to FORTRAN than it would be to work in FORTRAN to begin with.
With the advent of vector processors this practice is slowly becoming
obsolete.
%
scenario level:  n. A service [I think].  As in "This decision would, in
general, also provide your customers with a better scenario level".
(Circulated to approximately 100,000 people by an IBM Director.)
%
scenario walkthrough:  n. A meeting in which the designers of a product
outline the expected use of a product, in the form of various scenarios, and
then describe how the product will behave in each case.  See also inspection.
%
scenic route:  n. A slow path through an Electronic Network.  "Hey, my file
hasn't got to VM yet"...  "Which node did you send it through?"...  "K31"...
"Ah!  That's the RSCSSNA scenic route".
%
scope:  v. To delve into or investigate.  "We'll have to scope it before we
can come up with a firm answer".  This term derives from the abbreviation for
Oscilloscope, which used to be the tool of the first line of investigation
for any tricky electronic problem.
%
scratch:  v. To erase or delete.  "Please scratch the tape".  Scratching is
always a deliberate action, rather than an accident.  Also used as an
adjective "This is a Scratch Tape", which implies that the tape is being used
for temporary data and may therefore be scratched after use.  The term
Scratch is involved in one of the finest known examples of error messages.
There is a utility used for mounting tapes, called MOUNT.  If this command is
invoked with the parameters "MOUNT SCRATCH 181 RING" (a request to mount a
scratch tape, with a ring to indicate that it may be over-written), the
utility will in due course respond with the error message VLIB09010S
'SCRATCH' MUST BE SPELLED W/O THE 'A'.
%
script:  v. To format a document for printing.  SCRIPT is the name of the
command used to invoke the most widely used IBM formatter, the Document
Composition Facility.  "If you script this dictionary onto a page printer
you'll save a lot of paper".
%
seamless:  adj.  Of two or more programs melded in such a way that the
resulting package appears to have been designed as an entity.  See also
transparent.
%
secretary of task forces:  n. A person within a laboratory, site, division,
or other operating unit who takes on the tasks of keeping interim and final
reports for all task forces in his or her domain.  A second function is
advising leaders (Task Force chairpersons) and providing minutes about
previous Task Forces on similar subjects.  If the information thus collected
were used by higher management, the Secretary would save many person hours.
%
security:  n. Any aspect of company operations that protects assets, people,
or face.  One of IBM's most enduring interests.  Fuelled by court-cases and
viruses, security became the hot button of the 1980s.  Nearly all the useful
and workable security precautions have long since been in place, so now that
it has become a hot button security departments have had to bring in a whole
new range of security measures to show that they are doing something.  Where
physical security is involved, they usually do a good job [though a new
concept, that if an IBMer wears two badges he will be twice as secure, is
somewhat suspect].  By contrast, the requirements for data processing
security seem hastily thrown together and have undeniably affected the
ability of IBMers to do their work.  The net result, of course, has been
dissatisfaction - which used to be unheard of in IBM, and is in fact the only
real security exposure.
%
send to the world:  v. To distribute a piece of software electronically, as
in "That's good enough; OK, send it to the world".  This really does mean "to
the world" - software sent over VNET can reach fifty countries in a matter of
hours or even minutes [especially at Christmas-time].
%
senior bit:  n. The most significant bit in a byte.
%
separate:  v. To let go, persuade to leave, or fire.  Usage "I think it's
time he was separated from the business".
%
sequoia:  n. The unit of measure of a product specification document, that
is, the number of exceptionally large trees required to produce the quantity
of paper necessary to print the document.  In some circles, the size of such
a document is held to correlate directly [or inversely] with the quality of
the project described therein.  See also three-tree report.
%
service:  1. v. To handle [an interrupt].  It should be noted that interrupt
handlers seldom appear in AI programs.  2. v. To fix bugs in a machine or
program.  See critical service.
%
service machine:  n. A userid running under VM that instead of being the
"desk" of a human user, is instead just a virtual machine that runs a program
with little or no human supervision.  The program may carry out simple
(though non-trivial) services such as sending diary reminders to users, or it
may carry out far more complex tasks such as managing the security, data, or
backups for an installation.  The service machine is such a powerful concept
that many locations run dozens of them, and for much of the time the service
machines outnumber the real people using the computer (and sometimes use more
resources, too).  See also disconnected.
%
settle down:  v. Of a new version of a program to have the most obvious
problems fixed.  Often, installing a new release of system software uncovers
all kinds of problems, and one must wait until the stirred-up system has
settled down before installing new applications.
%
shadow:  n. A copy of a conferencing facility disk which is maintained as
up-to-date as possible by manual or automatic methods.  The distortion
between files of the master system and those of the shadow is a
counterexample to Einstein's postulate about the constancy of the speed of
light on computer networks.  See also catcher, master, pitcher.
%
shadow-sitter:  n. The individual who maintains a shadow (usually on a
part-time basis).  Shadow-sitters are an expanding breed within IBM and have
a folklore all of their own, such as tales of the great IBMPC crash of June
'84.
%
sheep dip session:  n. A sales seminar, usually on a vague topic such as
Computer Integrated Manufacturing, which is intended for a large audience of
generally poor prospects.  Often planned by staff managers to improve
Year-to-date buns on seats performance.
%
ship:  1. v. To move a product from a point A to a point B (even if the
vehicle or mode of transport would inevitably sink if placed on the surface
of an ocean).  It is possible to ship items by road, rail, aeroplane or even
by electronic networks.  2. v. To become available.  As in "This version may
never ship externally", or "When does AS/400 ship?" See customer ship, FCS.
%
shop:  n. The Data Processing section of an Information Service (IS).  Also
commonly used to mean "department", as in IS shop, DP shop, etc.
%
short:  adj.  Of a DASD string having fewer DASD units than the head of
string unit can support.  This will usually improve performance, but takes
more floor space and dollars (the controller DASD ratio is higher than it
could be).  See also A-Box, Model A.
%
short card:  n. A PC expansion card or adapter that will fit in one of the
two "short" spaces located behind the diskette drives on some PCs.  See also
tall card.
%
showstopper:  1.n. An unfixed bug of such a serious nature that it is likely
to cause a crash.  2.n. An unsurmountable problem that may kill (halt) a
project.  3. n. An event that became an unforgettable lowlight of someone's
life.[In common usage this word means almost precisely the opposite of the
above; a section of a performance that is so good that applause interrupts
the show.]
%
shriek:  n. An exclamation mark (point).  This usage is especially popular
among APL users.  Also sometimes called a bang.  See also splat.
%
side sucker:  n. A program that uses an intemperate amount of system
resource.  From the metaphorical "That application really sucks in the sides
of a 4381".
%
sidecar:  n. An expansion box for the late PCjr.  So named because it came as
a unit that attached to the side of the processor box.  [The "jr" in PCjr
apparently was intended to suggest the title "Junior", and has little to do
with television soap operas set in Texas; even so, the cry of "who shot JR?"
can often be heard abroad.]
%
silent majority:  n. end users with an IQ of less than 110.  Also called
discretionary users.
%
silver bullet:  1.n. A memo or phone call from someone with sufficient power
to stop a section of the corporation from proceeding down a wasteful or
foolish path.  2.n. A part of a product plan (or something wishfully thought
to be part of a product plan) that will cure all a customer's ills.  An easy,
painless, magical, and costless solution to an intractable opportunity.
[Mythical] 3. n. The metallic toggle switch in the centre bay of an orange
box.  Like a BRS, it restarts the system.
%
silver fox:  n. A member of the IBM Quarter Century Club (someone who has
been with IBM for 25 years or more), or (less often) any old-timer IBM
employee.
%
sit:  1. v. To perform one's contractual obligations, to work.  As in "Where
do you sit?" Primarily used at manufacturing plants and laboratories to ask a
person where his or her office is located.  Not used so often in the field
since "sit" and "work" are less likely to be synonymous.  2. v. (Of a
program) To be placed, be found.  "This Xedit macro sits on the Tools disk".
%
six sigma:  adj.  High quality.  From statistical theory; 99.9999998 percent
of the area under a normal curve is within plus or minus six standard
deviations (usually designated by the greek character sigma) from the mean.
Allowing a reduction of 1.5 sigma for anticipated variation in the mean over
time, one ends up with a 99.99966 percent coverage - approximately 3.4
defects per million parts; or 3.4 failures or errors per million
opportunities.  Usage "We're aiming for a six sigma product".
%
skip to channel one:  v. To go to the top of a new page.  This is an
instruction, to a computer-controlled printer, that had its origins in the
days when printers (such as the model 1403) had their vertical movement stops
(tabs) encoded on a wide loop of tough paper called a carriage control tape.
The carriage control tape had a number of "channels" that could be selected
to allow a variety of forward vertical movements.  Channel one was normally
reserved for "Top Of Form".  Thus, "Skip To Channel One" meant "skip the rest
of this page and go on to the next one".  [Occasional excitement was had when
a carriage control tape, overtensioned, split lengthwise along the drive
holes.  This meant that the tape would no longer rotate and the selected stop
would never be found.  The printer would then dutifully spew out the rest of
the box of paper at maximum speed.] See also carriage control character.
%
skunk works:  n. A hobby.
%
sky:  n. A place where something is supposed to happen, but never quite seems
to.  As in "Where the rubber meets the sky".  Used by business personnel to
refer to Headquarters locations, and by engineers and programmers to refer to
the Research Division.  Usage "Well, now that we have developed the action
strategy, let's take it to where the rubber meets the sky and see if they'll
approve it".  See also road.
%
slash:  n. The solidus, the oblique character "/".  Also slashslash - the JCL
identifier, as in "Slashslash deedee splat" (// DD *).
%
slide to the right:  n. An unplanned (though probably anticipated) slip.
Derives from the usual representation of a schedule, which starts on the left
side of a chart and ends on the right (typically with FCS).  Also used as a
verb "If Fred doesn't get his code running this week, we're going to have to
slide to the right by two weeks!"
%
slip:  n. An extension to a schedule deadline.  A slip implies that the
developer intends to complete the project, but was too aggressive in his
schedule.  As a rule of thumb, if a schedule slip of one month is announced,
the project is likely to be ready after two extra months.
%
slope shoulders:  v. To refuse to accept responsibility (for a problem).
Problems will usually visit a number of people suffering from sloping
shoulders before eventually finding someone whose shoulders are square enough
(or who is naive enough) to bear the problem.  Oddly, "Square Shoulders" is
not a verb in everyday use.
%
slot:  n. A position (for a person or logic card) to be filled.  "I have a
slot for a Project Programmer".  See also headcount.
%
slugnet:  n. VNET on a slow day.  [Some say on a fast day, and especially in
1988.] See also notwork, nyetwork.
%
slush:  v. To prepare a product for an IBM Software Distribution tape, but
with the understanding that it is not the "final" final version.  Slushed
precedes frozen in those products that have had a rocky development cycle.
See also cast in concrete, to-PID version.
%
smoke test:  n. The first power up of a device.  Originally a term for the
very first time that power is applied to new machine.  It now applies to any
power up of a device after internal components have been handled by the
person who turns it on; e.g., turning on a PC after adding an option card,
memory, co-processor, etc.
%
snail mail:  n. Archaic postal systems that use paper as the medium for
message transmission, rather than electronics or optics.
%
snow:  n. Random white dots appearing on the PC colour display when a program
does brute-force writes in the adapter memory.  Contrary to popular belief,
this feature was not provided to make compatibility with the 327x green
lightning possible when writing terminal emulators for the PC.
%
soapbox:  n. The (virtual) thing you take over when appending to a forum.
According to computer conferencing traditions, you are supposed to make an
allusion to it when a) your append is mostly personal beliefs with no hard
facts, and b) runs to more than 30 lines.  "Excuse me, while I hoist myself
up onto the soapbox".
%
social science number:  n. A rough estimate or statistic based on an
inadequate sample (or a guess), or a number that is an average that does not
necessarily predict the figures that will be obtained in practice.  A figure
that is usually better than nothing, but not necessarily so.  Originally used
by an Instructor of the Endicott Inspection Process course.
%
softcopy:  adj.  Held on a computer storage device, not printed on paper.
%
software engineer:  1.n. A person whose goal it is to construct large,
complex programs without actually having to write any code.  2.n. A person
who engineers others into writing code.
%
software rot:  n. See bit decay.
%
softy:  n. An affectionate term used by engineers to describe a software
expert who knows very little about hardware.  Software experts seem to have
no affectionate terms for engineers.
%
solution:  v. To solve.  (Probably originally from South Road Labs,
Poughkeepsie.) "We must solution this problem".  There may be a subtle
distinction here if a problem has been solved it disappears completely.  In
contrast, one that has been solutioned may still exist but will have
disappeared from formal reports.
%
Some Of Our Best People Are Working On It:  statement.  "This is a serious
problem, which we didn't anticipate".
%
source:  n. The highest-level (primary source) version of a piece of code.
The version that the author or owner will work with when changes or
enhancements are made to the program.  See also OCO.
%
speak:  v. Of a computer language or software to be proficient in.  In many
locations one can see signs on office doors such as "APL spoken here" or, in
the case of one CMS bigot at the original Westlake location, "No hablo
MVS/TSO".
%
speak to:  v. To talk about.  "Will you speak to these foils, please?" See
also talk to.
%
spearcatcher:  n. A person given the task of facing a hostile audience (of
any kind) for the purpose of giving calm, reasonable answers to angry
questions.
%
spec-writer:  n. The person who writes the functional specifications for a
product.  A product is usually specified in detail before being developed.
The specs (Specifications) are then formally reviewed in a variety of ways
before the product is produced.
%
special-case:  v. To allow for a special condition in a program.  "We'll have
to special-case the zero return code".  Special-case can be seen as a subset
of dual-path but the latter implies that either path is equally probable,
while a special-cased piece of code might be executed only rarely.  See also
fix.
%
special assistant to:  adj.  Idle.  A manager for whom no use can be found
any longer is made "Special Assistant to" some higher echelon.  His
activities from then on are completely without consequence.  See also staff
person, ROJ.
%
specify:  1.n. An option from a set of options, one of which must be chosen.
(As opposed to one from a set of options, none of which need be chosen.) "The
power supply for this model is a specify".  2.n. A specification.  "Could you
look up the specify for the Model 80 and tell me the feature number of the
pointing device?"
%
specs:  n. The document detailing the specifications for a product.  Usage
"If the specs say it should work that way..". See also specify.
%
speculate on:  v. To reveal secrets about, to answer honestly.  "Q Why does
the IBM PC Documentation refer to an assembler, when there is none
announced?" - "A I'm sorry, but I cannot speculate on that in public".
%
speed, flexibility, and accuracy:  n. An IBM marketing slogan for its
mid-20th-Century tabulating machines.  Unfortunately it became over-used, and
in some places evolved into a double entendre with a British slang phrase of
the period with the same abbreviation.  "What did you sell today?  - Speed,
Flexibility, Accuracy..". Once this happened, an unsuccessful attempt was
made to re-introduce the slogan as "Speed, Accuracy, and Flexibility".
%
speeds and feeds:  n. A Marketing presentation that is technically oriented,
in contrast to the typical presentation.  This is perhaps a reference to
fertiliser descriptions; the presentation is designed to speed the growth of
a market place by feeding it with inspiring information.  Its first usage in
computing, however, was a reference to a presentation that went into details
about the printing speeds and paper feeds available with a new printer.  A
more plausible etymology suggests that it comes from analogy with common
machining jargon.  "Speed" refers to the rotational velocity of a drill or
mill bit, and "feed" to the linear velocity with which it moves into (or
across) the workpiece.  Thus to machine a piece with the proper finish yet in
minimum time, one must calculate the proper "speeds and feeds".  By analogy
one talked about the speeds of a processor family and the feeds (e.g. cards
per minute) of a series of input devices.
%
spin system:  1.n. A version of a major control program.  The term "Spin" was
originally used by OS developers (around 1970) in the form "spin nn" to
identify a particular development level of a release prior to its FCS.  Thus
"spin 11" might become the PID release version of, say, MVT release 19.  2.n.
The current (released) version of a system.  The system that FE are prepared
to fix bugs on.  (Pre-FCS systems are not spin systems, for this usage.) This
sense probably refers to the system that is actually spinning on the active
system disk drive.  See floor system.
%
spindle:  1.n. Disk axis, and, by extension, disk unit or disk pack.  Systems
people tend to speak in term of "spindles" since it used to be the unit of
access by the main computer.  Using the term "disk drive" can be misleading
since some IBM disk drives, like shoes, were sold in pairs.  The issue is now
further confused, since on the 3370 and 3380 devices, there are two actuators
on each spindle; hence two addresses known to the host computer can refer to
a single set of spinning magnetic disks (one spindle).  2. v. Of a card to
wrap around a pin, bobbin, or finger.  A violation of the First Commandment
of card care and maintenance "Do not fold, spindle, or mutilate".
%
spinning chocolate:  n. Large, high-revenue, magnetic disk storage devices.
A marketing term, a reference to the brown colour of magnetic disks (which is
due to their being coated with a mixture of materials including ferrous oxide
- rust).
%
splat:  n. An Asterisk.  As in the JCL statement "// DD *" (pronounced
"slashslash deedee splat").  See also Nathan Hale, shriek, slash, star, *.
%
in sponge mode:  adj.  Intending to listen but not contribute to a
discussion.  As in "I'm at this meeting in sponge mode".
%
spontaneously occurring software generated error:  n. A bug.  From the excuse
used by a software contractor to explain the delay in the delivery of a
typesetting program.
%
spool:  1. v. To move data from one disk pack to another.  From the term
Spool, meaning to put data in temporary storage while awaiting delivery to
its final destination.  Usage "Please spool that new file to me".  See also
punch, net.  "SPOOL" has become a common verb, but originally was itself an
acronym signifying Simultaneous Peripheral Operations On Line.  This acronym
originated with the 7070 computer, which had a system of interrupts that let
one program a peripheral activity (e.g., card-to-tape, tape-to-print,
tape-to-card) while a main program was running.  But there was no monitor in
the system, so if (for example) you programmed an application to print out a
tape while your program was running, and there was more printing to be done
when the job had finished, either you dedicated the mainframe to the print
function or you could lose the end of the print-out.  Spooling was therefore
somewhat ineffective until the advent of the System/360 with the INTRA and
INTER job monitors.  [Before spooling was "perfected", the usual procedure
was to direct all print output to a tape (tape spool?) and then subsequently
print it from the tape using a special tapeto-print peripheral.] 2.n. The
space occupied by such buffered data.  "Did the system crash because spool
filled?"
%
squatterize:  v. To borrow or make use of an item, without removing it from
its original location.  As in "If the terminal is not yet set up I will go to
John and Sophie in Pascal to squatterize a screen".
%
stack:  n. Alternative [usually incorrect] name for a queue.  This usage
probably originated in Cambridge (MA), at the Scientific Center there.
%
staff person:  n. A person with little responsibility but with an amount of
power directly correlated to personal charisma.  It is usually very hard to
determine how seriously one should deal with a staff person.  A staff person
is usually supposed to be helping the workers accomplish their jobs but more
often is asking about something or asking for something.  Staff persons can
usually be ignored completely.  However, occasionally someone with a great
deal of charisma lands in a staff job and carries great weight with higher
management (usually yours).  This particular breed of "staff" can be
difficult to detect, and must be treated with respect.
%
standard IBM keyboard:  n. A mythical computer input device.  The Corporate
implementation of the Loch Ness monster.  Everybody has heard about it, lots
of people talk about it, very few claim to have seen it, and none would want
to meet it.  A step in its evolution is known as the converged keyboard.
%
star:  n. An asterisk.  See *.
%
star out:  v. To comment out lines in files in which comments are indicated
by a leading asterisk (star).
%
statement of direction:  1.n. A statement describing a commitment to a
comprehensive (e.g., text processing) strategy incorporating all current
products.  2.n. A phrase used to cover up the absence of any strategy, or to
admit a lack of foresight and planning.
%
steel storage substructure:  n. A rack.  As in the 3480 product presentation
(ZV11-6107, Page 9) "The cartridges are held in a removable 20-pack made of
polystyrene that fits into a 74-inch high by 20-inch wide steel storage
substructure (rack)".
%
straight-wire:  v. To make a change or connection that is transparent to a
user or system.  Derived from the electrical engineering term used when a
complicated piece of circuitry is replaced by a simple wire.
%
strategic:  adj.  Used to designate a major IBM product, to which IBM is
prepared to commit significant resources.  A project manager will do anything
to get his or her product classified "strategic".
%
strategic horizon:  n. The total period ahead that is being considered for
planning purposes.  Nominally two years, it is typically two months and
becomes two weeks at bad times such as just before the Spring Plan.
%
strategic plan:  n. See Spring Plan.
%
strawman:  n. A plan or proposal that is unfinished or not fully thought
through; one that is being set up as a target for others to throw spears at
or knock down.
%
stress:  v. To test a piece of hardware or software by increasing the
(electronic) load on it beyond that expected in normal use.  "Stress testing"
is used to test software with the philosophy that a heavy load is more likely
to show problems (especially windows) than a light load.  See also exercise,
exerciser.
%
stretch:  v. To work overtime.  As in "We'll have to stretch to make that
deadline".
%
stretch target:  n. A goal that probably is impossible.  As in "We're setting
stretch targets next year".
%
string:  n. A set of peripheral devices, each connected to the next in line,
supported by a single control unit.  This applies almost exclusively to DASD
and tape devices.  See also Model A.
%
sub-system:  n. Any product which has already been grouped (physically or on
paper) with another as a system.  Also applied to any IBM product to imply it
ought to work in conjunction with some other product; for example, CICS might
be described as a "sub-system" in "a VTAM environment".
%
sugar cube:  1.n. A small synthetic foam sponge parallelepiped that is used
to prevent the movement of the end of a magnetic tape, by being wedged
between the sides of the tape reel.  Usually black, but brown or white in
France.  See also grommet.  2.n. In continental Europe (where sugar cubes are
often not cubes) the electronic modules used on circuit cards which have a
whitish look due to their metal cases.  See also sardine can.
%
sugg:  (sug) n. A suggestion.  A formal response to an APAR that implies that
the the APAR is accepted as a suggestion and could be implemented one day; it
does not describe a permanent restriction.  Introduced in the late 1970s.
%
suggestions programme:  n. A formal mechanism for submitting suggestions for
saving money.  Known as a lottery whereby an employee can (by wasting IBM
time filling in a form) get cash for ideas which someone else will have to
implement.  Indeed, sometimes a whole task force can be set up to consider
the suggestion.
%
suitably programmed host computer:  n. A host computer that might be used to
support a "box" that provides local computing power.  This phrase implies
that a) No IBM-provided software will do the job, and b) the development
group making the "box" doesn't know how to write the host support, but
someone should be able to work it out.
%
sunset:  v. To withdraw support for a product or a range of products.  Usage
"We'll sunset that range in late '89".  See also functionally stabilized.
%
super:  adj.  Used in the Marketing Divisions (and possibly elsewhere in the
company) as a euphemism for "Bull" and its derivatives.  "Super" is an
excellent example of dialectal and idiolectal variation within IBM.  Its
meanings vary from "Wonderful" to "Rubbish" via incredible (normal or
alternative meaning) depending on cultural sub-group.  Alternative terms with
probably the same meanings include"Fantastic", "Horse Apples", etc.
%
supervisor state:  n. See problem state.
%
supplication language:  n. See command language.
%
surface:  v. To raise, or bring to someone's attention.  "We should surface
that issue at the next staff meeting".
%
symbol:  n. A sequence of characters that forms a symbolic code for some
other sequence.  Originally provided in text formatters so that common
phrases or uncommon characters could be represented by a more convenient
sequence, symbols are now used in more general communication.  By convention
(from various macro processors and languages) symbols start with the
character - hence one might see " deity" appear in a discussion, with the
implication that one should insert the deity of one's choice at this point.
%
sysprog:  n. Systems Programmer.  An affectionate term for the systems
programmer responsible for a department or small location.  This person is
expected to be a hardware and software expert, to have infinite patience when
dealing with ordering procedures, security requirements, and users, and of
course to control enormous computing resources.  Usage "My sysprog always
grumbles if I ask for more than 100 Meg of disk storage at a time".
%
system:  n. A word appended to the description of any group of two or more
modules or products which are announced or developed together.  The intention
is to give an impression that the products result from a careful and unified
design process.  For example, "3270 Information Display System" may give some
people a feeling of assurance that the 3278 keyboard really was carefully
designed for use under the VM operating system.  See also sub-system.
%
tablature:  n. The tables in a document.  Usually has nothing to do with the
true meanings of the word, which include "stone tablet", "musical notation",
and "work of art".
%
tailgate:  v. To go through a badge-controlled access door without using your
own badge.  This is done either because you were able to catch the door
before it closed, or because the person in front of you was nice enough to
hold the door open for you.  Even if there is no physical door, as in a main
lobby, to pass the badge reader without inserting your badge is considered
tailgating.  A heinous action.
%
take:  n. A position in a discussion or argument.  As in "My take on this is
that it's unimportant".
%
talk to:  1. v. To discuss.  "I will talk to that detail later".  Usually
means that the speaker hopes his audience will drop the subject.  See also
speak to.  2. v. To communicate with another (usually of machines).  For
example, "These machines talk to each other, but do they understand?  Is one
talking French and the other listening in German?  (While an English-speaking
security person eavesdrops?)" See also speak to.
%
tall card:  n. A PC expansion card or adapter that will only fit in the
PC/AT.  The PC/AT box, being higher than earlier varieties, accepts "taller"
cards.  See also short card.
%
tanstaafl:  (tan-stah-fil) n. There Ain't No Such Thing As A Free Lunch.
From Robert Heinlein's The Moon is a Harsh Mistress.  Used to explain pricing
policies to a customer - a fashionable way to say "You pays your money and
makes your choice".  It may also remind the customer that he, in the end,
pays for the extended lunches that marketing representatives (from any
company) "treat" him to.  See also pay for the coffee.
%
target:  1.n. A goal (usually a date) toward which the members of a project
work.  2. v. To aim to complete by.  "Let's target this decision for
November" 3. n. A termination flag (again, usually a date) arbitrarily
affixed to the end of a project.  See slip.
%
target date:  n. A date by which a given event must occur.  "Let's set a
target date" actually means "Let us agree on a date at which, if the event
has not yet occurred, we'll start looking for someone or something to blame".
%
task force:  1.n. A high-powered group of experts appointed to solve some
problem of pressing urgency.  [Official Definition.] 2.n. A useful place for
management to hide people who have nothing better to do than natter on about
things.  [Note It is said that task forces have occasionally produced
(useful) results.  There exists little evidence to support this hypothesis.]
3. n. A group of friends and one or two experts gathered to again affirm the
predefined conclusions of the leader.  The gathering can be convivial fun or
a crashing bore.  The activity may benefit the leader's CYA position.  See
also secretary of task forces.
%
tattooed:  adj.  Of an IBMer die-hard.  According to folklore, long-term
IBMers have their IBM badge tattooed on their chests.
%
technical vitality:  n. Visible use of leading-edge (advanced) technology.
This is interpreted in some development labs as "using recent vendor
technology".  This phrase is also used at a lower level as an excuse to hire
new personnel or order new machines.  "Manager of Technical Vitality" can be
a penalty box assignment.
%
technology:  n. Some particular flavour of silicon manufacturing process.
"We can't put the whole channel on one chip until we go to the next
technology".
%
temporary assignment:  n. See permanent move.
%
temporary building:  n. A prefabricated building intended as temporary office
space.  Temporary buildings usually have a life span that far exceeds that of
more permanent structures.  This is an international constant in IBM - some
of Hursley's 5-year temporary buildings are still standing after 18 years.
See temporary assignment, module.
%
tenant:  n. A person that works at a location, but not for the division that
runs the location.  Often treated as a "second-class" citizen in any
consideration of space, services, or resource.
%
tent card:  n. A rectangular card, folded down the middle lengthwise, on
which a name is written to identify a participant in a meeting.
%
terminal:  n. A device (usually consisting of a display screen, keyboard, and
other hardware) that is at the end of the chain of hardware, systems, and
interfaces between a program and its user.  The term is generic; many
terminals nowadays are simply PC's running terminal emulation software (which
may be all that they run).  The term is best avoided by salespeople working
in the medical sector.
%
terminate:  v. To release someone from IBM employment.  This deadly verb is
used to describe the action of losing an employee.  "He [his employment] will
be terminated".  Rumour has it that (ex-) employees do survive this process,
if not from the point of view of IBM.  Interestingly, even loyal employees
are terminated should they happen to transfer between IBM companies.
%
test:  1. v. In a good development laboratory, to allow real users to use a
product for a significant amount of time before announcement.  2. v. In a bad
development laboratory, to get a few bored or unmotivated people to try one
or two of the things mentioned in the product specification.  That is, to try
the things the developers had already considered.
%
test bucket:  n. A set of test cases to run against a product during
development to check that it performs basic functions correctly.  "You must
run the test bucket against all code changes".  This term implies (always
incorrectly) that the set of test cases is complete and provides a full
functional verification of the product, encompassing all possible
combinations of input, output, timings, and error conditions.  See also
bucket, regression bucket.
%
text:  1.n. Executable code, usually with addresses unresolved (known
sometimes as object code).  "The compiler produces one text deck for each
source file".  2.n. Textual (documental) material.  Data which are in
ordinary ASCII or EBCDIC representation.  "Those are text files, you can
review them using the editor".
%
thank you:  n. "End of message".  Used by many computer centres as a secular
alternative to Amen "All systems will be going down in one minute.  Thank
you".
%
thesis:  n. See paren.
%
thin-slicing baloney:  n. Hair splitting, but starting from an indefensible
and absurd position.
%
think small:  v. To reduce problems to a series of smaller problems.  A
hardware or software test strategy; the technique being to exercise the most
primitive functions first to prove to yourself that they work, before trying
the more complex (and presumably failing) tasks.  When people forget this
basic strategy, they are gently reminded to "think small".
%
thought:  v. The slogan of the IBM retirees club in Auckland, New Zealand.
See THINK.
%
thrash:  v. To think very hard but not accomplish much.  "John needs some
help on this problem - he's thrashing".  Refers to the computer malaise in
which the system uses more time organising the resources available than it
gives to the users.
%
three-handed keyboard:  n. A 3278 or 3279 keyboard with the APL feature.
%
three-tree report:  n. A very large, fat, report printed on a 3800 or other
fast computer printer.  Variants include Five-Tree and Seven-Tree Reports.
See also kill a tree, sequoia.
%
through:  v. To pass on to, or work through.  As in "I do not wish to through
activities to another group which may create user dissatisfaction by
decreasing support level".
%
throughput:  n. Any measure of the processing power of a computer, in terms
of the number of pieces of work in some unit of time.  "The new model has
twice the throughput of the old".  See also MIPS.
%
time-stamp, timestamp:  1.n. An annotation to either paper documents or
electronic data that indicates the time and/or date of some (often undefined)
happening.  The accuracy of a time-stamp seems to be directly proportional to
the obscurity of the units in which it is expressed.  For example, the date
on a buck slip is often unrelated to the document to which it is attached,
even though it is almost always written in an easily understood form.  On the
other hand, MVS allows one to determine a time of day as a count of 26.04166
microsecond timer units since midnight, and provides the difference between
local time and Greenwich Mean Time in units of 1.048576 seconds.  2. v. To
mark with a time-stamp.
%
time delay:  n. Delay.  [What other kind of delay is there?]
%
time-frame, timeframe:  n. A range of dates during which an event will occur.
When used in a question, its intent is to elicit a target date without
seeming to be too aggressive, as in "What sort of time-frame are we talking
about?" Can also be used in a response "We're looking at a July time-frame
for completion".  An important usage note the date when used in a response
always means the earliest possible date to the questioner (1 July, in the
example above) and the latest date to the responder (31 July).
%
tip of the ice cube:  n. The visible part of something very small and
insignificant.  "That task force report is just the tip of the ice cube".
%
tired iron:  n. Data processing equipment that is perfectly functional
(because most of the bugs have been fixed) but has been superseded by a new
line of devices.
%
to-PID version:  (phonetic beheading of stupid) 1.n. A version of a software
product made available to internal users by the development group, which is
supposedly a copy of the distribution tape prepared and shipped to PID.  This
is rarely the same as the tape sent to customers, since developers often send
more than one tape to PID at different times.  See also golden diskette.
2.n. An unreadable tape.  This usage refers to the practice (pioneered, it is
said, by CPD Raleigh) of sending an unreadable tape to PID when the software
isn't ready yet.  By the time PID discovers the "mistake", the real version
will be ready (or so it is hoped).
%
to go nonlinear:  1. v. To escalate a decision or concern to a higher level
of management without going though every intermediate level of management.
That is, not following the normal line (chain) of management.  Derived from
the engineering graphical representation of equations or processes that
suddenly "blow up".  See also line management, food chain.  2. v. To have an
excessive, almost certainly emotional, response to a situation or stimulus;
to show the symptoms of displacement.  "I tried to talk to him about that bug
in his code but he went nonlinear".
%
to go open kimono:  1. v. To reveal everything to someone.  Once you have
gone open kimono, you have nothing more to hide.  (This is the more common
sense.) 2. v. To give someone a tantalising glimpse of a project (i.e.,
enough to get him interested but not enough to give any secrets away).  [This
is an interesting example of the same jargon having two rather different
meanings.  This may, and does, cause amusing misunderstandings at times.]
%
toeprint:  n. A footprint of especially small size.
%
token:  n. An 8-character alphanumeric operand.  This size was chosen because
it just happened to fit the size of one of the System/360 atomic units of
storage (the doubleword).  Some operating systems and programs used to (and
often still do) insist on parsing all input and truncating any words longer
than 8 characters.  [Especially annoying to those with 9-letter surnames.]
See also how hard would it be.
%
token ring:  n. A local area network architecture in which computers are
connected to a ring of wires or fibres around which messages (authorised by a
token - rather like a relay baton) are passed; a possible physical layer for
SNA or OSI.  Not to be confused with the Tolkien Ring, although the purposes
are similar "One ring to rule them all, One ring to find them, One ring to
bring them all and in the darkness bind them, In a LAN with more nodes where
the stations lie".
%
tolerant:  adj.  Of a program able to tolerate a certain system environment
without crashing.  By implication the program will run, but may have
limitations or may not be able to take full advantage of the environment.
"Yes, it'll run under XA, in toleration mode".
%
toolsmith:  n. One whose delight is the creation of tools.  "Tool" here
refers to any program (software) that helps people - preferably many people -
do what they want to do as easily and as pleasantly as possible.
%
topside:  n. The higher management echelons of a project or group.  "To go in
topside with a problem" means to attack the problem from top management
downwards.
%
tortoise-and-hare problem:  n. The problem that arises when a recent version
of a file (or an update) sent over the network overtakes an older version of
the same file, due to difference in size or network routing.  This, unless
precautions are taken, usually results in a backlevel version for the
recipient (often a service machine or conferencing facility).  The same
problem can affect users directly when pieces of electronic mail arrive in
the wrong order - sometimes leading to costly errors.
%
touch base with:  v. To talk about something to someone who would expect to
be informed.  Usage "I shall go touch base with management about that
problem".  This term is understood to be a loan word from the language
associated with a tribal ritual called "baseball".
%
tourist information:  n. Additional interesting but irrelevant information
given in a presentation.  For example "Status Customer running with no
problems.  TSO response time 11 minutes.  Transaction rate 11.1397 per
second".  The second and third sentences are tourist information if the
subject of the presentation is system availability.  This is probably derived
from tourist guide books or maps that not only provide information about
getting from place to place, but also give a collection of other information
about each place.
%
tower:  n. An extension to a library, or suite, of programs that is built
upon a previously available lower level "base" or "platform" of programs.
This type of extension is in contrast to extensions made by modifying the
base, and often leads to structurally sound systems - provided the base is
stable enough.  The term is used most often by those for whom it is a novel
idea.  See also application tower.
%
toy:  1.n. A program that can be readily understood.  2.n. A project in which
the writing of the code is a significant part of the effort.  In a "real"
project, coding is a negligible portion of the costs.  3. adj.  Of a tool
great for teaching but lacking the basic facilities needed for doing real
work.  The classic example in computer languages is Pascal.  See also Mickey
Mouse.
%
tradeoff document:  n. A paper describing the pros, cons, and assumptions
that were used in arriving at a decision.  Usually written after the fact,
and therefore "a list of reasons why we did what we did and why we didn't do
what we didn't do".
%
trailing-edge:  adj.  Slow to change (cf.  leading-edge ). Used in marketing
to denote an account who are not interested in SNA, MVS, PROFS, etc.  Usage
"XYZ are a real trailing edge account".  (Note that "account" describes
people in this usage, hence the plural is correct.)
%
translucent:  1. adj.  Of a change claimed to affect a user or system very
slightly.  Used when a claim of transparency is obviously untenable.  2. adj.
Of a change requiring a huge effort to accommodate.
%
transparent:  1. adj.  Of a change claimed to have no adverse effects on a
user or system.  Used when talking to change control to clinch an argument.
"But it's transparent!" Sadly, transparency seems a relative thing
[relatively rare] - after all, if truly transparent, why make the change?
See also seamless.  2. v. to go transparent.  To avoid responsibility for
something by providing no solid place on which blame can be rested.  As in
"When they found out that a GPD person caused the problem, they went
transparent on it".
%
trap D:  v. Of a program running under the OS/2 operating system to crash.
From the identifier, the number 13 in hexadecimal, of the interrupt (and its
handler, or trap) raised when a program tries to access a resource, such as
storage, which it does not own.  Usage "Whenever I run your program from
diskette it trap Ds".
%
trawl:  v. To find out, by sending out large numbers of automatic requests,
what information is available from newly set-up service machines; to look for
new service machines.
%
tri-lead:  n. A wire that consists of a central conductor with an earth
(ground) wire each side.  Effective as a signal carrier, but the contacts
have been known to be less than ideal - so it is just as well that the number
of wires in central processors is actually going down with complexity, rather
than increasing.  If the bad connection happened to be the ground wire (which
was only connected to ground at one end) then the resulting floating
conductor acted as a marvellous antenna; the noise it picked up was then
efficiently coupled to the signal wires.
%
tri-lead trichinosis:  n. A condition in which the silver signal (centre)
conductor of a Tri-lead causes a shortcircuit between that conductor and one
or both of the adjacent ground conductors due to chemical migration.  Nothing
to do with the worm infestation resulting from the eating of infected and
insufficiently cooked pork, and in no way a religious statement.
%
trick:  1.n. A piece of code, or a programming algorithm, that cannot be
understood by a newly trained programmer.  The term is used during
programming phase reviews "The use of the translate function to reverse the
string is a neat trick, but it can be made clearer and more understandable by
the use of a DO loop".  2.n. On an engineering model, a quick design change
made to flatten a bug.  If good, it will eventually go into the official
design.  If bad (the bug is still there, or another bug appears) then another
trick will be tried.
%
trickological:  adj.  Written more to glorify the tricks than to get the
function performed.  A trickological program of the highest order can be
comprehended only by its author.  It is especially easy (indeed, almost
trivial) to write one of these in APL.  Perhaps a pun on "trichological"
[referring to the study of hair or hairiness]?
%
trivial:  1. adj.  Possible.  Used to convey the impression that the speaker
is an expert in a subject and that the method of solution should be
immediately obvious to everyone else in the room.  Normally used when no one
in the room (including the speaker) can think of a solution.  2. adj.  Of
passwords predictable.  As in "Your husband's name is a trivial password".
3. adj.  Easy.  This usage implies that if the speaker had the responsibility
of carrying out the task, it would be done in a matter of minutes.  But,
alas, it is someone else's job.  4. adj.  non-trivial.  Too long, or simply
uninteresting, so that the speaker does not really want to do it.  "That's a
non-trivial change".
%
true blue:  adj.  Of a customer account using only IBM equipment.  See also
all-blue.
%
tube:  1.n. A display screen.  2. v. To send for display.  "Can you tube me
that ADMGDF file?"
%
tube-jockey:  n. A person who spends all of his or her working time (that is,
time not spent at a coffee machine) pushing buttons on a keyboard without any
noticeable results.  This is the modern version of "a paper-pusher".  The
most visible kind spend all day appending to non-technical forums, and can be
recognised by their compulsion to sign every append with self-bestowed titles
showing how clever they are.
%
turbo:  adj.  Of a revised program better, faster, and bigger.  This term is
a spin-off from the automobile industry, though of course before it can be
used in a computing environment it has to be acronymised.  The most
interesting acronym so far is TURBO The Ultimate Really Better Overall.  This
was used to describe a non-strategic project at Yorktown that aimed to
develop an improved CMS.
%
tweak:  v. To change in a small way, to tune.  May be applied to software or
to hardware.  See also one-line fix.
%
twenty-pounder:  n. A particularly brassy form of wingtipped shoe.  As in
"There he was, all dressed out in his power suit and twenty-pounders".
%
twin-tail:  n. A method for connecting an IBM communications controller to
two different computers so that they share access to a common communications
network, or to connect two BSC lines to work like a single fullduplex line.
Carries all the usual human problems and implications of trying to serve two
masters.  (From the electronics term for a balanced two-transistor - often
FET - amplifier, "twin-tailed pair".)
%
type one:  adj.  Of software fully supported, as for System Products.  This
term refers to one of the old IBM software service agreement levels of
support.  The term has come to mean "high quality" software, though (since
much of it is very old) it is not necessarily up to today's standards.  [This
author has campaigned for some time for "Type Zero" code - software that is
guaranteed correct and reliable.] See also home-grown.
%
umbrella PTF:  n. A PTF that contains fixes to several (related and
inter-dependent) products.  Almost always a nightmare for users, because the
complexity of the change means that human error will prevail, something will
get overlooked, and something will break after the PTF has been applied.
%
uncork:  1. v. To bring a problem to public view.  As in "Who uncorked that
mess?" 2. v. To lose one's temper.  As in "He really uncorked when he found
out what it was going to cost".  See also come out of the bottle.
%
undercover micro:  n. A microprocessor whose presence is neither documented
nor obvious to the user of the hardware in which it is contained.
%
unit:  n. By U.S. law, something that can be purchased separately.  Note that
for this reason, IBM (and other computer manufacturers) no longer make CPUs
(Central Processing Units), but CPs (Central Processors).
%
up:  adj.  Working normally.  The opposite of down.  "Is the system up yet?"
%
update:  n. A change to a piece of software or hardware made in order to
enhance its capabilities or to correct a problem.  Often refers to a
particular portion of software (the delta) that can be merged automatically
with the source of a program (if you have it) to form a new, updated,
version.  "Can you send me the update that lets it work with RSCS Version 2?"
See also OCO.
%
uplevel:  v. To install a more recent version of a program (not necessarily
the most up-to-date).  "When are you planning to uplevel RSCS?"
%
uplift:  n. An increment.  Commonly used in pricing discussions.  It has
nothing to do with emotional or moral effects.  Usage "If we vendorize that
unit, what will be the uplift on the price tag?"
%
user:  n. One who uses (rather than creates) a product.
%
user-cuddly:  adj.  Of software or documentation especially user-friendly.
[This phrase was first heard from a customer at the SHARE conference in March
1984, describing the VM REXX interpreter.]
%
user-friendly:  1. adj.  Of a program usable by someone who is not a computer
expert.  A program that was used by more than twenty people (whose comments
were acted upon) before being distributed.  2.n. Of hardware or software not
easy to use, but needing to be sold.  See also user-cuddly, user-hostile.
%
user-hostile:  adj.  Of a program actively unpleasant to the user; not
user-friendly.  Often due to the use of illchosen words for messages, as when
the user mistypes a command, and the program responds, brusquely, "Illegal
Command" [Go Directly To Jail].
%
user error:  1.n. Documentation error.  2.n. Poor design.  3. n. (rare) A
mistake made by a user.  As used in the MVS/XA System Programming Library
"Because user errors often produce unpredictable results, the user should try
to avoid them".
%
user exit:  n. A published external interface that allows access to the
internals of a piece of software.
%
user orientation:  n. A term for the kind of manual now described as user
friendly.  This was first used in 1968 at a meeting of hardware publications
managers, when it was stated that the greatest need was for publications
developers to understand who the readers were and why they were readers.  It
took fifteen years for this truth to be widely appreciated and applied.
%
userid:  (you-zer-eye-dee) 1.n. "nom de terminal".  2.n. A nickname that
identifies a person (user) to a computer system or to other users.  It is
most understandable if selected by the user (and in this case may even be
related to the name of the user).  If selected by a program written by
someone with a tiny mind, it is likely to be cryptic (KR39232E, 86612345).  A
strange rule was used in the La Gaude laboratory until recently; one could
have any userid one wanted so long as it began with the letter "L".  Yorktown
Research once had a more involved rule you could have any userid you liked,
provided it was no more than seven letters, and did not begin with the
letters "IBM" (or any other string that already existed as a userid).
[History can causestrange anomalies "IBMPC" was allowed, "IBMVM" was not.]
See also nodeid, vnetid.
%
utility:  n. A program that provides a general service that may have a
variety of uses.  For example, sorting and printing programs are often called
utilities.  The name implies a lack of novelty, and describes a
"bread-andbutter" program.  See also facility.
%
value add:  n. An improvement in function or performance.  "What's the value
add in release 3?" See added value.
%
vanilla:  adj.  Of standard flavour, e.g., as shipped to customers.  As in
"You mean it's possible to run vanilla CP?" See also chocolate, mocha,
flavour, and PID.
%
vaporware:  n. Hardware or software that is announced [not by IBM!] for
availability at a later date, but never materializes.  In the case of
PC-related products, this is often because the announcing company itself has
vaporized.
%
vary:  v. To change a device from online to offline, or vice versa, usually
while the computer it is attached to continues to operate.  From the OS
command VARY, still available on VM and MVS systems.  As in "We'll vary that
CPU on and see if we can come up MP".
%
vector processor:  n. Any machine with a non-370 compatible architecture that
runs at a speed of over 3 MIPS.  There is an implicit slight here that it is
not a real "commercial" machine, since vector processors typically are used
for scientific applications.  Presumably (so it is thought) when a "vector
processor" is given a commercial job stream, it will not run any faster than
the fastest 370.  [Attitudes to vector processors have changed dramatically
since the announcement of the 3090 Vector product in 1985.] See minicomputer.
%
vehicle:  n. An indirect means to achieve some result (usually in the
marketplace).  "We will focus on the F machines as the key vehicle for the
new user interface".
%
vend out:  v. To contract production of some item to an outside vendor.  A
favourite way to avoid security restrictions - quite recently the contract
for making the foils for a presentation to the Corporate Management Committee
to summarise the IBM corporate five-year plan was vended out.
%
vendor:  1.n. A company that either supplies a product or service to IBM, or
supplies something to IBM customers.  See also OEM.  2. v. To release
headcount (to comply with cuts or to supply a new project) by employing
contract labour to carry out maintenance and/or development on a project.
Despite the observation that even more people (including contractor
personnel) are now involved with the project (since IBM must still perform
planning and contract supervision) this is viewed as a wise use of resources.
%
vendor technology:  n. Semiconductor technology produced outside IBM.  The
implication is that any variety of technology can be produced by IBM, but
"out there" they can raise only one type.  Vendor Technology Logic (VTL) was
synonymous with TTL (TransistorTransistor Logic, never manufactured by IBM)
in the 1970s.
%
vendorable:  adj.  Allowed to be vended out.  Usually heard as "Not
Vendorable".
%
vendorize:  v. To hire a sub-contractor (vendor) to do something that was
previously done in-house.  A vendorized product is one that was originally
built by IBM but is now largely assembled by a sub-contractor.
%
verb:  n. Any word (i.e., any noun may be misused as a verb).  "There is no
noun in the American language that cannot be verbed".
%
verbiage:  (ver-bij, ver-bedge) n. A term used to refer to any kind of
documentation.  The similarity of this word to "garbage" does not seem
accidental, and the word is often misspelt as "Verbage".  The use of this
term has the effect of belittling the documentation, either because one wants
to under-emphasise its importance, as in "I have the design flowchart all
done.  All I have to do is add the verbiage", or because the documentation is
wordy, as in "That user's manual sure has a lot of verbiage in it", or
because the reader is too "busy" to be bothered to read it.
%
vertical:  adj.  Specialised (rather than broad-based, or horizontal).  As in
"...some of the more specialised micro dealers are starting to find
themselves up a pretty tight vertical niche".
%
via:  n. A pathway from one face of a printed circuit card (or layer in a
chip) to the other.  Originally always described the plated-through holes in
IBM multi-layer printed circuit cards (a scarce resource), but now more
loosely applied to hardware mechanisms for taking a short-cut from one place
to another, or to any construction method that can take advantage of vias.
%
vibration tested:  adj.  Having survived careless or deliberate mechanical
abuse, such as being dropped or kicked.  [Such treatment cures faults in
equipment almost as often as it causes them.]
%
virgin:  adj.  Of a program unmodified (e.g., as received from PID).  It is
interesting to note that the first modification to such code is usually that
which is the most desired.  Also used to describe a silicon wafer before the
first etching to place transistors or other components on it; a tape or paper
before first impression; etc.  See also vanilla.
%
virtual:  adj.  A term used to indicate that things are not what they seem to
be.  Generally means that you can see it, but it is not really there.  As in
virtual disk, virtual memory.  (As opposed to something that is transparent
"It's really there, but you can't see it".)
%
virtual Friday:  n. The Wednesday or Thursday before a long weekend in the
USA for which the Thursday or Friday (respectively) is a holiday.  Usage
"Don't hold that meeting tomorrow afternoon - it's a virtual Friday".
%
virtual machine:  n. See VM.
%
virtualize:  v. Under VM, to simulate a resource for a virtual machine.
"VM/XA SP virtualizes central processors and central storage but not expanded
storage".  In other words, VM/XA SP can simulate processors and central
storage for an operating system running under it, but cannot simulate
expanded storage.
%
visibility:  n. Kudos, importance.  A project that has "visibility" is much
in the eye of others.  This makes it high (political) risk; the workers
involved may find themselves showered with awards - or may find themselves
the scapegoats for others.
%
visionary:  n. Someone who reads the outside literature.
%
visual footprint:  n. The apparent size of a piece of computer equipment -
such as a terminal - as perceived by a user.  For example, many televisions
have acres of wasted space each side of the screen; others, with a smaller
visual footprint, generally look more elegant.
%
vital records:  n. Records which are supposed to allow a project to restart
with minimal loss in the event of disaster.  As they are usually three to six
months out of date, and often suffering from inconsistency, it is just as
well that they have never really been needed.
%
vnetid:  (vee-net-eye-dee) n. The network address of a computer user or
service machine.  It is usually the combination of an untypeable nodeid with
a cryptic userid.  This often makes the identity of the originator of a
message very difficult to determine if no real name is included in the
message.  How is one to guess that XES7208C at GYSVMHD1 is good ol' Kurt in
Heidelberg?  Sometimes the only way to answer is to begin with "Dear XES7208C
at GYSVMHD1."..
%
wait state:  n. A period during which a processor is idle, for example,
waiting for input, output, or memory activity to complete.  Rare in modern
multitasking systems, but common on workstations and personal computers even
today.  System/360s had a wait light which indicated that the processor was
in wait state; it's said that some engineers replaced this with a burnt-out
bulb to avoid drawing attention to this implied inefficiency.
%
walk around the block:  v. To convince someone to do something by repeated
requests and explanations, sometimes by higher and higher levels of
management.  "He didn't want to take the assignment, but we walked around the
block a few times and he saw the light".
%
walk in the woods:  n. A time spent out of general circulation or out of
power.  As in "The product was a disaster, so they sent him for a walk in the
woods".  [Hoping, perhaps, that the lions would get him?] See penalty box,
lion food.
%
walk up and use:  adj.  Of a software application, or a combination of
hardware and software ready to use immediately.  "You plug the display,
keyboard, and printer into the system unit and you have a walk up and use
desktop publishing system".
%
wall follower:  n. A simpleton, or one who goes by the book.  "Joe is a real
wall-follower".  An early robotbuilding contest which involved running a maze
was won by a mechanism which only sensed and followed the right-hand wall.
It was called Harvey Wallbanger.  Robots that tried to learn as they
traversed the maze did not do as well.
%
war room:  1.n. The nerve centre of the operation to control the development
or maintenance of certain products.  A room in or near to a development
project, filled with displays, telephones, specifications, wiring diagrams,
microcode listings, and the like.  The purpose is to employ the cream of the
crop of engineers associated with a project to "make war" on failing
machines.  Almost any solution can be used, but the best ones can be
translated immediately into ECs (Engineering Changes).  The modern term for
such a place, "Support Center", somehow does not have the same aura (or
success).  When Big OS was first released (circa 1965) a room was dedicated
in building 705, Poughkeepsie, to provide immediate assistance to users.
This room was designated the "World-wide APAR Response Room" - a name
inevitably shortened to "war room".  It was probably the first so named.
2.n. A room set aside in a marketing (sales) location for intensive planning,
predicting, and point tallying at crucial times in the year.  The room looks
like a battlefield, since the walls, tables, and floor are generally covered
with flipchart paper full of numbers and words, presenting the expected
customer installs and the resulting points (until the end of the war).
%
warm body:  n. A real person (usually a programmer or engineer).  A manager's
empire is measured by the headcount allocated to him or her, but the
headcount is not necessarily filled.  Usage "How many warm bodies will you
have by April?"
%
warm fuzzies:  1.n. The kind of feeling it is alleged that you get when you
think you are proceeding in the right direction, or when you are being
treated well by your manager.  This state of mind is usually of short
duration, and is succeeded by cold pricklies.  2.n. Messages produced by a
program to indicate that it is alive and well but is likely to take some time
to finish its processing.
%
water:  n. Orders for equipment which the customer does not intend to accept.
"The first-day orders set a new record, but they must be at least a third
water".  Major causes include place-holding orders while the customer tries
to figure out what has been announced; dropout due to multi-year delivery
schedules; and Christmas presents to deserving salesmen.
%
water MIPS:  n. Processing power that is provided by large water-cooled
computers such as 3090s.  As in "Longer term, we see all computing power
being delivered by water MIPS or desk MIPS".  See also desk MIPS, MIPS.
%
watercool:  v. Usually of a computer to cool, using chilled water.
%
water-cooled engineer:  n. A service engineer who refuses to work on
machinery that is not water-cooled.  "If it isn't water-cooled, it's a
terminal!" (Only large processors are water-cooled.)
%
wave a dead chicken:  v. To offer a forlorn hope; a burnt offering or
witchcraft.  As in "I'll just wave a dead chicken over the dump", which means
"I'll give it a go, but don't expect too much".
%
we agree:  response.  "No, we haven't done that yet, and we wish we'd thought
of it ourselves".  (Response to questions of the form "Shouldn't you return
the misdirected mail to the sender, instead of just throwing it away?")
%
weenie:  n. The ";" (semi-colon) character on a keyboard.  "To get back to
the first screen, type in a 2 comma 7 weenie and hit ENTER".
%
wet:  adj.  Of a mainframe cooled by chilled water.  This describes
water-cooled computers such as the 308x and 309x ranges.  Mainly used in the
locution "wet box".
%
whim of record:  n. A plan of record that changes weekly (or more
frequently).
%
white socks type:  n. Anyone in CSD or FED, divisions now amalgamated to form
the NSD (National Service Division [A name unlikely to catch on in the UK,
where National Service used to be the euphemism for military conscription]).
IBM engineers traditionally wore white socks under dark suits, and it is said
that some still do.  "Anyone for tennis?"
%
wild duck:  n. A creative technical person who does unconventional things, or
at least does things in an unconventional way.  Implies respect, and an
acknowledgement that many of that person's ideas turn out to be valuable.  It
is said that IBM does not mind having a few wild ducks around - so long as
they fly in formation.  This term was created by T. J. Watson Jr., who told a
story (by the philosopher Kirkegaard) about a flock of wild ducks that landed
near a farm.  Some got fed by the farmer and stayed, and either died of
obesity or got eaten.  The truly wild ones flew away - and survived.
%
window:  1.n. A timing problem due to a logical error.  An unlikely set of
circumstances which were not allowed for, although probably understood.
Usually the amount of code required to "close the window" is inversely
proportional to the size of the window opening.  Murphy's Law normally
prevails, so the problem caused by the window will not appear until after FCS
- by which time the person who left the window open is nowhere in sight.
2.n. A portion of a display screen.  It can also be used as a verb to mean
the process of defining the windows on a screen.  "Who did the windowing on
this panel?" 3. n. An Early Retirement opportunity.  An occasional chance to
retire early on favourable terms.  There was one such window at the Owego
location a few years ago, and many people took advantage of it.  Everyone
there ['tis said] who is even close to retirement kept wondering (aloud) when
the next window would be.  Their prayers were answered in 1986.
%
window-dressing:  1.n. Something put in a business case to make it look
better or even good.  2.n. A "graphical" or "window" interface added to an
otherwise deficient program to make it appear more attractive.
%
wing-tipped warrior:  n. An experienced and proficient IBM Marketing
Representative.  A Wing-Tip is a style of dress shoe that has a "wing like"
pattern of dots punched in the leather on the toes.  See also rep, power
suit.
%
wing it:  v. Just go and do it any old way [does not imply any skill in
improvisation].  "In this location, we design the hardware, software, and
microcode for a project.  When no one can figure out why it doesn't function,
we then spend a few months writing specifications of what was thought to be
developed".  When the final result is apparent, it is always discovered that
the result of winging-it is not what was intended.
%
winged comments:  n. Comments set on the same line as a program statement and
which (in the ideal case) only refer to that one statement.  If statements
are kept short and the winged comments are descriptive then such commentary
can considerably enhance the quality of the code.
%
wingtips:  n. Official IBMdom.  As in "Yes, Mr.  Customer, if this system
fails, we'll Darken The Sky With Wingtips".  See also help.
%
winnie:  n. A small format (usually 5.25 inch) hard disk.  This is a
diminutive for Winchester disk and [I think] has no connection with the noise
often made by the disk.
%
wishlet:  n. A small wish, more practical than a WIBNI.
%
wishlist:  n. A list of WIBNIs and Nice To Haves for a program or other tool.
When "prioritized", this may become a priority list ; but in general the
future of the items on the list is very variable, and depends largely on how
much spare time the author gets from IBM, family, etc.  in order to implement
items on the Wishlist.
%
woodshed:  n. A figurative [virtual?] place where a person is taken for
admonition.  A place of temporary residence, unlike a penalty box.  As in
"John Akers took his managers to the woodshed after seeing the Fortune
magazine article on Most Admired Corporations".  In North America in olden
days, the woodshed was far enough from the house that children could be
disciplined there without unduly disturbing the rest of the family.
%
woof and whinny:  n. A high level and perhaps rather theatrical "show and
tell" with a lot of yelling and screaming.  See dog and pony show.
%
wordsmith:  v. To create or edit a memo, letter, or other document with a
word processor or editing program, usually with a view to improving it or
making it more acceptable to others; to fiddle with the words in a document.
As in "I have to wordsmith that memo before I send it to anyone".
%
work-around:  1.n. A technique suggested by an engineering or programming
department for getting around a major blunder until a more permanent repair
can be made.  "We are aware that the real-time clock will give ambiguous
date/time readings at midnight.  If you MUST run your on-line applications 24
hours a day, you should instruct your machine operators to put the machine in
STOP for the minute or so around midnight.  This work-around will have to be
employed until 1992, when we plan to release a new feature that corrects this
minor imperfection".  2.n. A design change installed in a machine under test.
The work-around is usually to allow continued testing by the bypassing of a
failing function.  The bypassed functions must be fixed (all work-arounds
removed) before the machine design can be accepted.  [This technique can also
be applied while debugging programs.]
%
working as designed:  adj.  Of a program or piece of hardware not working as
a user wants, but nevertheless working as specified.  Used as a reason for
not accepting a criticism or suggestion.
%
write-only:  adj.  Of program code unreadable, unfathomable.  Used in a
derogatory way to refer to others' coding practices, especially when used to
refer to APL "Since his APL code is write-only we'll have to find some other
way to communicate with the software folk".  The term is also used
affectionately between APLers "I understand your routine perfectly.  This
proves once again that APL is not write-only..".
%
wrt:  preposition.  With Respect To.  Also used (with confusion) as an
abbreviation for "write".  See also btw.
%
yabafu:  n. An append that is empty or contains only boiler plate text.
Originally (1986) meant "Yet Another Blank Append From Uithone", referring to
numerous empty appends from that nodeid which plagued conferences and which
were caused by user interface problems in some Uithone-specific exec.  Can
also describe any major publication blunder (such as the XT/286 advertisement
in the Daily Telegraph of 29 December 1986 which featured a [then absurd] 20
Meg slimline diskette).
%
yearend:  n. A time, strictly speaking in December, of intense workload (and
paranoia) in sales and marketing areas.  This is the period when salespeople
strive to meet their targets and everyone else tries to keep out of their
way.  The exact "date" of yearend is around January 7th, depending on
flexibility of local systems and the deadlines set by headquarters locations.
%
yellow brick road:  n. Route 9, Poughkeepsie.  The road on which you travel
to see the Wizard of OZ.  See OS.
%
yellow layer:  n. Communications software.  See layer.
%
yellow wire:  1.n. A hardware fix.  Products whose connections were mainly
printed-circuits had fixes and overflows manually connected using yellow
wires.  The reliability of a product is inversely proportional to the number
of yellow wires.  2. v. To wire-wrap.  "Of course they had trouble building
the 801 prototype using ECL - it was yellow-wired!" A piece of hardware that
is built entirely manually may be connected by wires coated in a yellow
plastic, connecting components by wrapping the copper wire around their
projecting parts.  This technique for prototyping was superseded by
meltable-insulation wiring, around 1977.  See also blue wire, purple wire.
%
yo-yo:  v. To repeatedly crash and be restarted; to go up and down many
times.  As in "TOROLAB6 has been yo-yoing all day today".
%
zap:  1. v. To alter the machine code of a program by storing directly into
main storage, or by running a program (known as SuperZap) to have a similar
effect on the disk-resident copy of a program.  This practice started in the
days when a proper change to program source followed by reassembly was a task
measured in hours.  Now a term for shoddy, incomplete work which is likely to
cause trouble in future because the running version of a program no longer
agrees with its source - a situation that inevitably leads to problems.
"We'll just zap it for now and hope tomorrow never comes".  Nowadays zapping
is a dying art, and can itself take hours, but it may well see a renaissance
as OCO becomes wide-spread.  See also patch.  2. v. To use a "Zapper" to
discharge static electricity near various sensitive parts of a computer.
This test determines whether the machine will survive a visit in the dry
winter-time by an active young woman wearing a silk blouse, silk slip, and
wool skirt.
%
zero-content:  adj.  Of a document or presentation containing no useful
information.  (Though probably very wordy and beautifully illustrated.) See
content.
%
zipperhead:  1.n. One who has a closed mind.  Said to be most frequently used
in Development Laboratories, especially those with a high average age of
employee.  2.n. See beamer.
%
zoo:  n. The VM Systems Programming department (circa 1978) in Toronto,
Canada (now called VM Software Services).  The nickname arose because many
people in the department collected stuffed animals; in time it became
pervasive - software tools designed and written by the Zoo were distributed
widely, and there are few VM systems in IBM without at least one module that
includes the epithet "Property of the Zoo".  These modules have the prefix
EMS (DMS, which belonged to CMS, with the D changed to E for "Extension").
Students of British broadcasting will recognise the relevance of the Monty
Python sketch that ends "and now it's time for the penguin on top of your
television set to explode".
%
