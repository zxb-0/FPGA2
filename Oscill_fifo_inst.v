Oscill_fifo	Oscill_fifo_inst (
	.data ( data_sig ),
	.rdclk ( rdclk_sig ),
	.rdreq ( rdreq_sig ),
	.wrclk ( wrclk_sig ),
	.wrreq ( wrreq_sig ),
	.q ( q_sig ),
	.rdempty ( rdempty_sig ),
	.rdfull ( rdfull_sig ),
	.rdusedw ( rdusedw_sig ),
	.wrfull ( wrfull_sig )
	);
