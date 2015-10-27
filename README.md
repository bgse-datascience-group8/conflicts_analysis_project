# Group 8 Dataset Milestone Redux

### The question and the problem it concerns

How do political and social conflicts (such as a protest, demands and threats) affect the likelihood other political conflict event nearby, in space or time?

The answer to this question may affect how government and society can address, prepare for and possibly thwart conflict. Conflicts requires reactionary government resources, namely police and administrative forces. Understanding of the likelihood of conflict events may enable the alleviation of the negative externalities of conflict, such as violence.

### The dataset

[GDELT: Global Data on Events, Location and Tone](http://gdeltproject.org/data.html) is a dataset of 200 million geolocated events spanning 35 years <sup>[1](#341mill)</sup>. Data collected are daily from a variety of international news organizations and categorized using their [Conflict and Mediation Event Observations Event and Actor Codebook (CAMEO) coding system](http://data.gdeltproject.org/documentation/CAMEO.Manual.1.1b3.pdf).

The strength of the data is how exhaustive it is (that is, having a large pool of sources) and its events classification algorithms. From initial exploration, events are identified through an initial source, and subsequent articles may be identified as relating the same event. Such articles are counted as +1 to the NumArticles column of the original event. Thusly, the significance of an event can be quantified through the events table columns NumArticles referencing the event as well as NumMentions. The data is also categorized according the actors and event types described in the CAMEO coding system.

It is also all free which we like, a lot. It also has a lot of [documentation](http://gdeltproject.org/data.html#documentation), which we also like a lot.

Concerns <sup>[2](#gdelt-weaknesses)</sup> about the dataset are its size and opacity. While offering insights quickly, through Google’s BigQuery, it was the experience of the authors the daily  free quota on using this service runs out after about 5 successful queries. To reduce the total size of analysis, we limit the scope of our analysis to events in the US in the past year for the 3 events code listed below in The solution. The dataset’s opacity lies in source and algorithm verification: GDELT does not release a list of its sources <sup>[3](#sourceurls)</sup> nor the algorithms it uses to classify each event.

### The solution and methodology

Using the GDELT dataset, we will identify those events coded as "threaten", "demand" or "protest" and quantify their relationship to other events in terms of time and location. Once this quantification has been made, we can analyze how one event impacts the probability of other events of the same type in nearby locations or in the days directly following the original event.

The hypothesis is there will be a higher probability of events happening nearby in time or distance or both to any other given event.

To test the hypothesis that the distribution of the distances (D1, ... , Dm) from some event (E1) to all directly following events<sup>[4](#directly-following-events)</sup> (E2, ... , Em) is a distribution with greater probability for low values of D.

### Additional Exploration

We also plan to explore and visualize a time-lapse spread of conflict over time and how this determines the actions taken by the government or regulatory authorities. 


*Footnotes*

<a name="341mill">[1] According to the Google Big Query metadata on their events database, there are actually over 341 million rows in the events database. In our limited querying we have found this is the result of recording the same event when any one value changes, for example when an event is associated with 2 different locations.</a>

<a name="gdelt-weaknesses" href="http://politicalviolenceataglance.org/2014/02/20/raining-on-the-parade-some-cautions-regarding-the-global-database-of-events-language-and-tone-dataset/">[2] Article analyzing weaknesses in GDELT dataset</a>

[3] <a name="sourceurls">It does however include a source url per event, just not a distinct list of news sources from which it collects events</a>

[4] <a name="directly-following-events">Our initial definition of *directly following events* will be those events from the same day through the following week</a>
