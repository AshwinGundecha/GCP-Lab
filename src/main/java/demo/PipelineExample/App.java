package demo.PipelineExample;

import org.apache.beam.sdk.Pipeline;
import org.apache.beam.sdk.io.gcp.bigquery.BigQueryIO;
import org.apache.beam.sdk.io.gcp.pubsub.PubsubIO;
import org.apache.beam.sdk.options.PipelineOptions;
import org.apache.beam.sdk.options.PipelineOptionsFactory;
import org.apache.beam.sdk.transforms.DoFn;
import org.apache.beam.sdk.transforms.ParDo;
import org.apache.beam.sdk.values.PCollection;
import com.google.api.services.bigquery.model.TableRow; 

public class App 
{
    public static void main( String[] args )
    {
       PipelineOptions pipelineoptions = PipelineOptionsFactory.create();
       
     //create the pipeline option object
       Pipeline pipeline = Pipeline.create(pipelineoptions);
       
     //read the message from pubsubIO
     PCollection<String> pubsubmsg = pipeline.apply(PubsubIO.readStrings().fromTopic("projects/nttdata-c4e-bde/topics/uc1-dlq-topic-0"));
     
     PCollection<TableRow> bqRow = pubsubmsg.apply(ParDo.of(new ConvertToStringBq()));
     
   //write the PubSub message into the big query table as an output
     bqRow.apply(BigQueryIO.writeTableRows().to("nttdata-c4e-bde:uc1_2.account")
				.withWriteDisposition(BigQueryIO.Write.WriteDisposition.WRITE_APPEND)
				.withCreateDisposition(BigQueryIO.Write.CreateDisposition.CREATE_IF_NEEDED));
       
   //run the pipeline
       pipeline.run().waitUntilFinish();
    }
    
    @SuppressWarnings("serial")
	public static class ConvertToStringBq extends DoFn<String, TableRow> {

		@ProcessElement
		public void processing(ProcessContext processContext) {
			TableRow tablerow = new TableRow().set("id", processContext.element().toString())
					.set("name", processContext.element().toString())
					.set("surname", processContext.element().toString());

			processContext.output(tablerow);

		}
	}
}
