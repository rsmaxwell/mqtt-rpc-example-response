package com.rsmaxwell.mqtt.rpc.example.response.handlers;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.rsmaxwell.mqtt.rpc.common.Response;
import com.rsmaxwell.mqtt.rpc.response.ResponseHandler;

public class GetPages extends ResponseHandler {

	private static final Logger logger = LogManager.getLogger(GetPages.class);

	public Response handleRequest(Map<String, Object> args) throws Exception {
		logger.info("getPages: handleRequest");
		return success("[ 'one', 'two', 'three' ]");
	}
}
