# Group 8 Dataset Milestone Redux

### The question and the problem it concerns

Are political and social events correlated with similar types of events nearby, in space or time?

The answer to this question may affect how government and society can address and prepare for such events and thwart conflict-type events. Conflicts require reactionary government resources, namely police and administrative forces. Understanding of the likelihood of conflict events may enable the alleviation of the negative externalities such as violence.

**We will study specifically the time-space corrlations among "conflict" types of events such as protests, threats and demands.**

### The dataset

[GDELT: Global Data on Events, Location and Tone](http://gdeltproject.org/data.html) is a dataset of 200 million geolocated events spanning 35 years<sup>[1](#341mill)</sup>. Data are collected daily from a variety of international news organizations and categorized using the [Conflict and Mediation Event Observations Event and Actor Codebook (CAMEO) coding system](http://data.gdeltproject.org/documentation/CAMEO.Manual.1.1b3.pdf).

The strength of the data is its extensiveness and its events classification algorithms. Events are identified through an initial source, and subsequent articles may be identified as relating the same event. The significance of an event can be quantified using the columns `NumArticles` referencing the event as well as `NumMentions`. The data are also categorized according the actors, event types and sub-types and locations as described in the CAMEO coding system.

It is also free which we like, (a lot!). It also has a lot of [documentation](http://gdeltproject.org/data.html#documentation), which we also like, (also a lot!).

Concerns<sup>[2](#gdelt-weaknesses)</sup> about the dataset are its size and its opacity. The dataset’s opacity lies in source and algorithm verification: GDELT does not release a list of its sources<sup>[3](#sourceurls)</sup> nor the algorithms it uses to classify each event.

While queries for exploration and data download can be executed quickly using Google’s BigQuery, it was the experience of the authors the daily free quota on using this service runs out after about 5 successful queries. We limit the scope of our analysis to events in the US in the past year for the 3 events code listed below in The solution.

### The solution and methodology

Using the GDELT dataset, we will identify those events coded as "threaten", "demand" or "protest" and quantify their relationship to other events in terms of time and location. Once this quantification has been made, we can analyze how one event impacts the probability of other events of the same type in nearby locations or in the days directly following the original event.

The hypothesis is there will be a higher probability of events happening nearby in time or distance or both to any other given event.

We will test the hypothesis that the distribution of the distances (D1, ... , Dm) from some event (E1) to all directly following events<sup>[4](#directly-following-events)</sup> (E2, ... , Em) is a distribution with greater probability for low values of D.

### Additional Exploration

We also plan to explore and visualize a time-lapse spread of conflict over time and how this determines the actions taken by the government or regulatory authorities. 


### Example data

Querying<sup>[5](#see-scripts)</sup> for "protest"-type events with at least 10 article references occurring in the US on 26 October 2015, returned 3 results:

* [Some farmers upset that hydroponic crops carry organic label](http://www.sfgate.com/news/science/article/Some-Vermont-farmers-to-protest-possible-organic-6590183.php)

* [Demonstrators set up mock drill to protest gas pipeline](http://marcellus.com/news/id/130770/demonstrators-set-up-mock-drill-to-protest-gas-pipeline/)

* [Letter: Support Partners for Education Dem candidates](http://www.mainlinemedianews.com/articles/2015/10/25/main_line_suburban_life/news/doc5629431998829663782224.txt)



**Footnotes**
<br />
<sub>
[1] <a name="341mill">According to the Google Big Query metadata on their events database, there are actually over 341 million rows in the events database. In our limited querying we have found this is the result of recording the same event when any one value changes, for example when an event is associated with 2 different locations.</a>
</sub>
<br />
<sub>
[2] <a name="gdelt-weaknesses" href="http://politicalviolenceataglance.org/2014/02/20/raining-on-the-parade-some-cautions-regarding-the-global-database-of-events-language-and-tone-dataset/">Article analyzing weaknesses in GDELT dataset</a>
</sub>
<br />
<sub>
[3] <a name="sourceurls">It does however include a source url per event, just not a distinct list of news sources from which it collects events</a>
</sub>
<br />
<sub>
[4] <a name="directly-following-events">Our initial definition of *directly following events* will be those events from the same day through the following week</a>
</sub>
<sub>
[5] <a name="see-scripts">For exact queries, see scripts in the [scripts/](scripts/) directory in this repository</a>
</sub>

